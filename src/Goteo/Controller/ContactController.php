<?php
/*
 * This file is part of the Goteo Package.
 *
 * (c) Platoniq y Fundación Goteo <fundacion@goteo.org>
 *
 * For the full copyright and license information, please view the README.md
 * and LICENSE files that was distributed with this source code.
 */

namespace Goteo\Controller;

use Symfony\Component\HttpFoundation\Request;
use Gregwar\Captcha\CaptchaBuilder;

use Goteo\Library;
use Goteo\Library\Text;
use Goteo\Library\Page;
use Goteo\Application\Message;
use Goteo\Application\Session;
use Goteo\Application\Config;
use Goteo\Model\Template;
use Goteo\Model\Mail;

class ContactController extends \Goteo\Core\Controller {

    public function indexAction (Request $request) {

        $tags = array();
        $rawTags = Text::get('contact-form-tags');
        $listTags = explode(';', $rawTags);
        foreach ($listTags as $pair) {
            $pair = trim($pair);
            if (empty($pair)) continue;
            $pairTag = explode(']', $pair);
            $keyTag = trim(str_replace(array('[', '<br />'), '', $pairTag[0]));
            $tags[$keyTag] = trim($pairTag[1]);
        }

        $errors = array();
        $data = [];
        if($user = Session::getUser()) {
            $data['name'] = $user->name;
            $data['email'] = $user->email;
        }
        if ($request->isMethod('POST')) {

            $name = $request->request->get('name');
            $tag = $request->request->get('tag');
            $email = $request->request->get('email');
            $subject = $request->request->get('subject');
            $message = $request->request->get('message');

            // si falta mensaje, email o asunto, error
            if(empty($email)) {
                $errors['email'] = Text::get('error-contact-email-empty');
            } elseif(!Library\Check::mail($email)) {
                $errors['email'] = Text::get('error-contact-email-invalid');
            }

            if(empty($subject)) {
                $errors['subject'] = Text::get('error-contact-subject-empty');
            }

            if(empty($message)) {
                $errors['message'] = Text::get('error-contact-message-empty');
            } else {
                $msg_content = nl2br(strip_tags($message));
            }

            // check captcha
            if(!$user && $phrase = Session::get('captcha-phrase')) {
                Session::del('captcha-phrase');
                $captcha = new CaptchaBuilder($phrase);
                // captcha verification
                if (!$captcha->testPhrase($request->request->get('captcha_response'))) {
                    $errors['recaptcha'] = Text::get('error-contact-captcha');
                }
            }

            // check from token (ensures is a submit from the navigator)
            if($token = Session::get('form-token')) {
                Session::del('form-token');
                if($token !== $request->request->get('form-token')) {
                    $errors['form-token'] = 'Error submiting the form. Please try again!';
                }
            }

            $data = array(
                    'tag' => $tag,
                    'subject' => $subject,
                    'name'    => $name,
                    'email'   => $email,
                    'message' => $message
            );

            if (empty($errors)) {

                $to = Config::get('mail.contact');
                $toName = Config::get('mail.contact_name');
                if(empty($toName)) $toName = 'Goteo';
                // Obtenemos la plantilla para asunto y contenido
                $mailHandler = Mail::createFromTemplate($to, $toName, Template::MESSAGE_CONTACT, [
                        '%TONAME%'     => $toName,
                        '%MESSAGE%'    => $msg_content,
                        '%USEREMAIL%'  => $name . ' ' . $email
                    ]);
                // Custom subject
                $subject = ($tag ? '[' . $tag . '] ' : '') . $subject;

                $mailHandler->subject = $subject;

                $mailHandler->replyName = $name;
                $mailHandler->reply = $email;

                if ($mailHandler->send($errors)) {
                    Message::info('Mensaje de contacto enviado correctamente.');
                    return $this->redirect('/contact');
                } else {
                    Message::error('Ha fallado al enviar el mensaje.');
                }
            }
        }

        $captcha = null;
        // Generate a new captcha on non-logged users
        if(!Session::isLogged()) {
            $captcha = new CaptchaBuilder();
            $captcha->build();
            Session::store('captcha-phrase', $captcha->getPhrase());
        }
        // Generate a new form token
        $token = sha1(uniqid(mt_rand(), true));
        Session::store('form-token', $token);

        return $this->viewResponse('about/contact',
            array(
                'data'    => $data,
                'tags'    => $tags,
                'token'    => $token,
                'page'    => Page::get('contact'),
                'captcha' => $captcha,
                'errors'  => $errors
            )
        );

    }

    // Creates a new image
    public function captchaAction() {
        $captcha = new CaptchaBuilder();
        $captcha->build();
        Session::store('captcha-phrase', $captcha->getPhrase());
        return $this->rawResponse($captcha->inline());
    }

}

