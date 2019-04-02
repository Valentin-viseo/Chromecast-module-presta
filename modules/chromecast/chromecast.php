<?php

/// Important to tell the program we are using prestashop
if (!defined('_PS_VERSION_')) {
    exit;
}

class Chromecast extends Module
{
    //     //     /// Module name
    //     //     $this->name = "ChromeCast";
    //     //     /// Module version
    //     //     $this->version = "1.0";
    //     //     /// In case we include bootstrap css page
    //     //     // $this->bootstrap = true;
    //     //     ///in case we want to upload our module on the store
    //     //     /// $this->secure_key = Tools::encrypt($this->name)

    //     //     /// The language of our module (french / english /...)
    //     //     /// $this->language = Language::getLanguages()

    //     //     /// The authors of the module
    //     //     $this->author = "Viseo";
    //     //     parent::__construct();

    //     //     ///The name displayed on the store
    //     //     $this->displayName = $this->l("Chromecast Module");
    //     //     ///Description of the module
    //     //     $this->description = $this->l("Display product on a tv connected with Chromecast"); 
    //     //     /// Version of prestashop compatible with our module
    //     //     $this->ps_versions_compliancy = array('min' => '1.7.1.0', 'max' => _PS_VERSION_);
    //     //     /// Theme configuration
    //     //     // $this->module_path = _PS_MODULE_DIR_.
    public function __construct()
    {
        /// Module name
        $this->name = 'chromecast';

        $this->tab = 'front_office_features';
        /// Module version
        $this->version = '1.0.0';
        /// The authors of the module
        $this->author = 'Firstname Lastname';
        $this->need_instance = 0;
        /// Version of prestashop compatible with our module
        $this->ps_versions_compliancy = [
            'min' => '1.6',
            'max' => _PS_VERSION_
        ];
        /// In case we include bootstrap css page
        $this->bootstrap = true;

        parent::__construct();
        /// The name displayed on the store
        $this->displayName = $this->l('chromecast');
        /// Description of the module
        $this->description = $this->l('Description of my module.');

        /// Message to show for uninstalling
        $this->confirmUninstall = $this->l('Are you sure you want to uninstall?');

        if (!Configuration::get('MYMODULE_NAME')) {
            $this->warning = $this->l('No name provided');
        }
    }

    public function install()
    {
        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }

        if (
            !parent::install() ||
            !$this->registerHook('leftColumn') ||
            !$this->registerHook('header') ||
            !$this->registerHook('displayProductButtons') ||
            !Configuration::updateValue('MYMODULE_NAME', 'my friend')
        ) {
            return false;
        }

        return true;
    }

    public function uninstall()
    {
        if (
            !parent::uninstall() ||
            !Configuration::deleteByName('MYMODULE_NAME')
        ) {
            return false;
        }

        return true;
    }


    public function hookDisplayHeader() {
        $this->context->smarty->assign([
            'Message' => "This is a message",
            'Description' => "Shalala",
        ]);
        return $this->display(__FILE__, "views/header.tpl");
    }

    public function hookDisplayProductAdditionalInfo() {
        $this->context->smarty->assign("ok", "sisi");
        return $this->display(__FILE__, "views/button_product.tpl");
    }

}
