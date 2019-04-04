<div id="mymodule_block_home" class="block">
  <h4>Welcome!</h4>
  <div class="block_content">
    <p>Hello,
           {if isset($my_module_name) && $my_module_name}
               {$my_module_name}
           {else}
               World
           {/if}
           !
    </p>
    {debug}
    <a onClick="chromeCastSender.launchVideo()" title="Click this link">Click me!</a>
    <a href="{$my_module_link}">Redirection </a>
    <div id="noWomanNoCry">
      <google-cast-launcher> </google-cast-launcher>
    </div>
  </div>
</div>
