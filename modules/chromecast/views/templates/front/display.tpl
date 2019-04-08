{extends file="page.tpl"}
{block name="content"}
{if isset($html) && $html}
    <div id="log">
    </div>
{else}
    World
{/if}

<script type="text/javascript" literal>
    /// Function to decode html element to javascript '&lt' ==> '<'
    function htmlDecode(input){
    var e = document.createElement('div');
    e.innerHTML = input;
    return e.childNodes.length === 0 ? "" : e.childNodes[0].nodeValue;
    }

    /// Display the html
    const value = document.getElementById("log");
    console.log(value)
    value.innerHTML = htmlDecode(`{$html}`)

    /// Import script important for chromecast and jquery
    const importantScriptImportList = []
    JSON.parse(htmlDecode(`{$liens}`)).forEach((lien) => {
        const newScript = document.createElement("script");
        newScript.src = lien.src;
        newScript.crossorigin = lien.crossorigin;
       // lien.integrity? newScript.integrity = lien.integrity: {};
        document.body.appendChild(newScript)
    })

    /// Important javascript part for the chromecast
    const scriptJS = document.createElement("script");
    scriptJS.text =  htmlDecode(`{$js}`)
    document.body.appendChild(scriptJS);

</script>

{/block}
