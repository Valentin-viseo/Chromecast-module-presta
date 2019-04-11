  <chromecast-media template="val"> </chromecast-media>
<default> </default>

<script type="text/javascript" src="http://127.0.0.1:8000/coucou" >

</script>

<script>
  function htmlDecode(input){
    var e = document.createElement('div');
    e.innerHTML = input;
    return e.childNodes.length === 0 ? "" : e.childNodes[0].nodeValue;
  }
  localStorage.setItem("itemGood", htmlDecode('{json_encode($product.images)}') )
  console.log(htmlDecode(`{json_encode($product.images)}`))
</script>