<form method="post">
    <label for="urlfortoken">
        Enter the url of your e-commerce website.
    </label>
    <input id="urlfortoken" disabled/>
    <button onclick="GetToken(document.getElementById('urlfortoken').value)">
        Generate
    </button>
    <br />
    <input type="submit" value="Submit changes" disabled>
</form>

<script>
    let loading = false;
    const GetToken = (value) => {
        console.log(value)
        const myObj = {
            _url: "abdenourrrrr"
        };
        fetch("http://localhost:8000/register", {
            method: 'POST',
           
            body: JSON.stringify(myObj)
        })
        .then((response) => {
            return response.text()
        })
        .then((data) => {
            console.log(data)
        })
    } 
</script>