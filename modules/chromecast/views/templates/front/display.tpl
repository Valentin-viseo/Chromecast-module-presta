{if isset($html) && $html}
    <div id="log" onclick="number10({$html})">
      {* {$html} *}
    </div>
    <a onClick="number10('slt')">
    no women no cry
    </a> 
{else}
    World
{/if}

<script>
    const number10 = (variablemoi) => {
        console.log(variablemoi)
    }
    const tmp = document.getElementById("log");
    //tmp.innerHTML = "{$html}";
    console.log(tmp)
</script>
<a onclick="nulnulnul()">nulll </a>