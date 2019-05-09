 {if isset($status) && $status}
<p>
    The form is submitted
</p>
{else}
    <label for="urlfortoken">
        Generate a token for your website and submit changes
    </label>
    <button onclick="GetToken()">
        Generate
    </button>
<form method="post">

    <input id="urlfortoken" type="text" name="urlfortoken"/>
    <br />
    <input type="submit" name="buttonsubmit" id="submitButton" value="Submit changes" disabled>
</form>

<script>
    let loading = false;
    const GetToken = (value) => {
        const inputforurl = document.getElementById("urlfortoken");
        fetch("http://localhost:8000/register", {
            method: 'POST'
        })
        .then((response) => {
            return response.text();
        })
        .then((data) => {
            console.log(data);
            inputforurl.value = data;
            const submitButton = document.getElementById("submitButton");
            submitButton.disabled = false;
        })
    } 
</script>
{/if}