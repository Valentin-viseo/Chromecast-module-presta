{if isset($html) && $html}
    <div id="log">
    </div>
      {* {$html} *}
    {* </div>  *}
    {* <a onClick="numberone({$html})">
    no women no cry
    </a>  *}
    <a onClick="coucou()"> coucou </a>
    <input type="hidden" id="variableAPasser" value="{$html}"/>
    <input type="hidden" id="jsAPasser" value="{$js}" />
{else}
    World
{/if}

<script>
    const numberone = (variablemoi) => {
        console.log(variablemoi)
    };
    var variableRecuperee = document.getElementById("variableAPasser").value;
    document.getElementById("log").innerHTML = variableRecuperee
    var jsARecuperer = document.getElementById("jsAPasser").value;
    const myScript = document.createElement('script');;

    document.body.appendChild(myScript);
</script>