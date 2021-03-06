<?php

$this->layout('layout', [
    'bodyClass' => '',
    'title' => 'Make sure :: Goteo.org',
    'meta_description' => $this->text('meta-description-discover')
    ]);

$this->section('content');

?>

<?= $this->insert('invest/partials/project_info') ?>

<?= $this->insert('invest/partials/steps_bar') ?>

<div class="container">

	<div class="row row-form">
			<div class="panel panel-default invest-container">
				<div class="panel-body">

                    <h2 class="col-sm-offset-1 padding-bottom-2"><?= $this->text('invest-make-sure-title') ?></h2>

                    <?= $this->insert('invest/partials/invest_header_form') ?>

                    <?= $this->supply('sub-header', $this->get_session('sub-header')) ?>

                    <form class="form-horizontal" id="make-sure-form" role="form" method="POST" action="/invest/<?= $this->project->id ?>/<?= $this->invest->id ?>">

                        <?= $this->supply('invest-form', $this->insert('invest/partials/invest_address_form')) ?>

                        <?= $this->insert('invest/partials/invest_submit_form') ?>

					</form>


				</div>
			</div>
	</div>

</div>

<?php $this->replace() ?>
