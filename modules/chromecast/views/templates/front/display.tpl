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
    <input type="hidden" id="liensAPasser" value="{$liens}" />
{else}
    World
{/if}

<script>
    const numberone = (variablemoi) => {
        console.log(variablemoi)
    };
    var variableRecuperee = document.getElementById("variableAPasser").value;
    var jsARecuperer = document.getElementById("jsAPasser").value;
    const liensARecuperer = document.getElementById("liensAPasser").value;

    document.getElementById("log").innerHTML = variableRecuperee

    const myScript = document.createElement('script');
    myScript.text = "{literal}" + jsARecuperer + "{/literal}";
    
    let multiScript = JSON.parse(liensARecuperer);
    console.log(multiScript);
    let scripMax = [];
    multiScript.forEach((x) => {
        const someScript = document.createElement('script');
        someScript.src = x.src;
        someScript.crossorigin = x.crossorigin; 
        someScript.integrity? someScript.integrity = x.integrity: {};
        scripMax.push(someScript);
    })

    scripMax.forEach(async (x) => {
        console.log(x)
        setTimeout(() => {

        }, 2000)
        document.body.appendChild(x);
    })



    document.body.appendChild(myScript);
</script>