<?php

class chromecastdisplayModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        parent::initContent();
        $this->html = $this->CallApi("get", "http://127.0.0.1:8000/home");
        $this->javascript = $this->CallAPI("get", "http://127.0.0.1:8000/js");
        $this->liens = $this->CallAPI("get", "http://127.0.0.1:8000/liens");
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

    function CallAPI($method, $url, $data = false)
    {
        $curl = curl_init();
 
        switch ($method)
        {
            case "POST":
                curl_setopt($curl, CURLOPT_POST, 1);
 
                if ($data)
                    curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
                break;
            case "PUT":
                curl_setopt($curl, CURLOPT_PUT, 1);
                break;
            default:
                if ($data)
                    $url = sprintf("%s?%s", $url, http_build_query($data));
        }
 
        // Optional Authentication:
        curl_setopt($curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
        curl_setopt($curl, CURLOPT_USERPWD, "username:password");
 
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
 
        $result = curl_exec($curl);
 
        curl_close($curl);
 
        return $result;
    }
}