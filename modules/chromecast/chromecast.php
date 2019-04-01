<?php

/// Important to tell the program we are using prestashop
if (!defined('_PS_VERSION_')) {
    exit;
}

class Chromecast extends Module
{
    public function __construct()
    {
        $this->name = 'chromecast';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'Firstname Lastname';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = [
            'min' => '1.6',
            'max' => _PS_VERSION_
        ];
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('chromecast');
        $this->description = $this->l('Description of my module.');

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

    if (!parent::install() ||
        !$this->registerHook('leftColumn') ||
        !$this->registerHook('header') ||
        !Configuration::updateValue('MYMODULE_NAME', 'my friend')
    ) {
        return false;
    }

    return true;
}
public function uninstall()
{
    if (!parent::uninstall() ||
        !Configuration::deleteByName('MYMODULE_NAME')
    ) {
        return false;
    }

    return true;
}
}

/// Module class is prestashop class
// class Chromecast extends Module 
// {

//     public function __construct()
//     {
//         $this->name = 'blockproducts';
//         $this->tab = 'front_office_features';
//         $this->version = 1.0;
//         $this->author = 'Gabriel Manricks';
//         $this->need_instance = 0;
 
//         parent::__construct();
 
//         $this->displayName = $this->l('Products List Module');
//         $this->description = $this->l('Displays number of products in the home page.');
//     }

//     public function install()
//     {
//             if (parent::install() == false || $this->registerHook('displayHome') == false || $this->registerHook('displayHeader') == false || Configuration::updateValue('DP_Number_of_Products', 4) == false)
//                     return false;
//             return true;
//     }

//     public function hookdisplayHeader($params)
//     {
//         $this->context->controller->addCSS(($this->_path).'blockproducts.css', 'all');
//     }

//     public function hookdisplayHome($params)
//     {
//         $languageId = (int)($params['cookie']->id_lang);
//         $numberOfProducts = (int)(Configuration::get("DP_Number_of_Products"));
//         $productsData = Product::getProducts($languageId, 0, $numberOfProducts, "id_product", "ASC");
//         if (!$productsData)
//             return "error";
             
//         $products = array();
//         $link = new Link(null, "http://");
         
//         foreach($productsData as $product){
//             $tmp = Product::getCover($product['id_product']);
//             array_push($products, array(
//                 'name' => $product['name'],
//                 'author' => $product['manufacturer_name'],
//                 'desc' => $product['description_short'],
//                 'price' => $product['price'],
//                 'link' => $link->getProductLink(new Product($product['id_product'])),
//                 'image' => $link->getImageLink($product['link_rewrite'], $tmp['id_image'])
//             ));
             
//         }
//         $this->smarty->assign(array(
//             'products' => $products
//         ));
 
//         return $this->display(__FILE__, 'blockproducts.tpl');
//     }


//     /// Constructor where we define identity of the module
//     // public function __construct()
//     // {
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

//     // }

//     /// Important function that install the module inside the project => Called 
//     /// when we hit the install button
//     // public function install() {
//     //     die();
//     //     if (!parent::install() || 
//     //         !$this->registerHook("displayHeader") ||
//     //         !$this->registerHook("displayFooter"))
//     //     {
//     //         return false;
//     //     }

//     //     // return (parent::install()
//     //     //     && $this->registerHook('dashboardZoneOne')
//     //     //     && $this->registerHook('dashboardData')
//     //     //     && $this->registerHook('actionObjectOrderAddAfter')
//     //     //     && $this->registerHook('actionObjectCustomerAddAfter')
//     //     //     && $this->registerHook('actionObjectCustomerMessageAddAfter')
//     //     //     && $this->registerHook('actionObjectCustomerThreadAddAfter')
//     //     //     && $this->registerHook('actionObjectOrderReturnAddAfter')
//     //     //     && $this->registerHook('actionAdminControllerSetMedia')
//     //     // );
//     //     return true;
//     // }
// }
