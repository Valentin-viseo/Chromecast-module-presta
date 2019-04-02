{if isset($submit_form) && $submit_form}
<p>
    The form is submitted
</p>
{/if}

<p>
    {if isset($status) && $status == 'true'}
    All is good
        {else}
        Something wron happended!
    {/if}
</p>

<form method="post">
    <input type="text" name="chromecast_txt">
    <p>
    </p>
    <input type="submit" value="Submit changes">
</form>