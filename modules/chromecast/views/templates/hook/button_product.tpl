  <chromecast-media template="val"> </chromecast-media>
<default > </default>
<script src="http://www.gstatic.com/cv/js/sender/v1/cast_sender.js?loadCastFramework=1">

</script>
<script type="text/javascript" src="http://chromecast.snap.viseo.com/coucou" >

</script>


<script>
  function htmlDecode(input){
    var e = document.createElement('div');
    e.innerHTML = input;
    return e.childNodes.length === 0 ? "" : e.childNodes[0].nodeValue;
  }
  const productJsonList =  JSON.parse(htmlDecode('{json_encode($product.images)}'));
  const productListUrl = productJsonList.map((x) => {
    return x.bySize.small_default.url;
  })
  console.log(productListUrl)
  const myObj = {
    imageUrl: "https://thumbs.gfycat.com/OrderlyHarmfulCentipede-size_restricted.gif"
  };
  localStorage.setItem("prestashop_images", JSON.stringify(productListUrl) )
</script>