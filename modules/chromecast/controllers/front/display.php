<?php

class chromecastdisplayModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        parent::initContent();
        $this->setTemplate('module:chromecast/views/templates/front/display.tpl');
    }
}