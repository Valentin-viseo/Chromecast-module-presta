<?php

/// Important to tell the program we are using prestashop
if (!defined('_PS_VERSION_')) {
    exit;
}


include_once _PS_MODULE_DIR_ . 'chromecast/classes/HelperClass.php';

class Chromecast extends Module
{
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
            !$this->registerHook('displayProductAdditionalInfo') ||
            !$this->registerHook('DisplayFooterProduct') ||
            !Configuration::updateValue('CHROMECAST', 'my friend')
        ) {
            return false;
        }

        return true;
    }

    public function uninstall()
    {
        if (
            !parent::uninstall() ||
            !Configuration::deleteByName('CHROMECAST')
        ) {
            return false;
        }

        return true;
    }

    public function getContent() {
        if (Tools::getValue("chromecast_txt")) {
            $status = false;
            $message = Tools::getValue("chromecast_txt");

            // Store in db
            if (ConfigurationCore::updateValue("PS_CHROMECAST", $message)) {
                $status = true;
            }
            $this->context->smarty->assign([
                'submit_form' => true,
                'status' => $status
            ]);
        }
        return $this->display(__FILE__, "views/admin/admin.tpl");
    }


    public function hookDisplayHeader() {
        $nope = new HelperClass();
        // die($this->_path.'css/main.css');
        $this->context->controller->addCSS($this->_path.'views/css/main.css', 'all');
        $this->context->controller->addJS($this->_path.'views/js/ChromeCastService/ChromeCastSender.js', 'all');
        // $this->context->controller->addJS('www.gstatic.com/cv/js/sender/v1/cast_sender.js?loadCastFramework=1', 'all');
        $this->context->controller->registerJavascript(
            'monurl', // Unique ID
            'http://www.gstatic.com/cv/js/sender/v1/cast_sender.js?loadCastFramework=1', // JS path
            array('server' => 'remote', 'position' => 'bottom', 'priority' => 150) // Arguments
        );

    }

    public function hookDisplayFooterProduct() {
        $this->context->smarty->assign([
            'my_module_name' => Configuration::get('CHROMECAST'),
            'my_module_link' => $this->context->link->getModuleLink('chromecast', 'display')
          ]);    
        return $this->display(__FILE__, "button_product.tpl");
    }

    public function hooDisplayLeftColumn($param) {
        die($param);
    }

    // public function hookDisplayProductAdditionalInfo() {
    //     $this->context->smarty->assign([
    //         'my_module_name' => Configuration::get('CHROMECAST'),
    //         'my_module_link' => $this->context->link->getModuleLink('chromecast', 'display')
    //       ]);    
    //     return $this->display(__FILE__, "button_product.tpl");
    // }
}

