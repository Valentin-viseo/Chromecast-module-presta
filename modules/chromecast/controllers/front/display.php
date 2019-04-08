<?php


class chromecastdisplayModuleFrontController extends ModuleFrontController
{
    public function __construct()
    {
        parent::__construct();
        $this->helperFunction = new HelperClass();
        // die()
    }

    public function initContent()
    {
        parent::initContent();
        $this->html = $this->helperFunction->CallApi("get", "http://127.0.0.1:8000/home");
        $this->javascript = $this->helperFunction->CallAPI("get", "http://127.0.0.1:8000/js");
        $this->liens = $this->helperFunction->CallAPI("get", "http://127.0.0.1:8000/liens");
        $this->context->smarty->assign([
            "html" => $this->html,
            "js" => $this->javascript,
            "liens" => $this->liens,
        ]);
        $this->setTemplate('module:chromecast/views/templates/front/display.tpl');
        // dump($this->val);
    }

    public function setMedia() {
        parent::setMedia();
        $this->registerJavascript('chromecast', $this->module->getPathUri() . 'views/js/ChromeCastService/ChromeCastSender.js');
    }


}