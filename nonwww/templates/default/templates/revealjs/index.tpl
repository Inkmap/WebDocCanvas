<!doctype html>
<html lang="{$page.meta.language}">
<head>
    <meta charset="utf-8">
    <title>{$page.meta.titleTag}</title>
<!--
{*$page|print_r*}
-->
{include 'tpl/html_head_meta_social.tpl'}

    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />

    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui">

    <link rel="stylesheet" href="{if isset($page.relPathPrefix)}{$page.relPathPrefix}{/if}vendor/revealjs/css/reveal.css">
    <link rel="stylesheet" href="{if isset($page.relPathPrefix)}{$page.relPathPrefix}{/if}vendor/revealjs/css/theme/{$page.meta.skin}.css" id="theme">

    <!--[if lt IE 9]>
        <script src="{if isset($page.relPathPrefix)}{$page.relPathPrefix}{/if}vendor/revealjs/lib/js/html5shiv.js"></script>
    <![endif]-->

    <style type="text/css">
        .reveal .slide-number {
            font-size: 0.6em;
        }
        .txtshadowthick {
            text-shadow: 2px 2px 5px #000!important;
        }
    
        /* styles for background youtube video */
        
        .reveal .background-youtube-video {
            position: absolute;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
            width: 100%;
            height: 100%;
            max-height: 100%;
            max-width: 100%;
            display: none;
        }
        
        .background-youtube-video-controls {
            position: absolute;
            z-index: 1000;
            top: 0;
            left: 0;
            right: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            display: none;
            margin: 0 auto;
            width: 200px;
        }
        
        .background-youtube-video-controls div {
            background: #000;
            color: #fff;
            padding: 10px;
            display: inline-block;
            cursor: pointer;
            font-family: Arial, Helvetica, sans-serif;
            fill: #fff;
        }
        
        /* styles for slidein modal */
        
        .reveal .slidein-modal { 
            height: 550px;
            transform: translateY(550px);
            transition: transform 200ms;
            padding: 0 20px;
            opacity: 1;
            position: fixed;
            left: 0;
            right: 0;
            bottom: -10px;
            top: auto;
            margin: 0 auto;
        }
        
        .reveal .slidein-modal--active {
            transform: translateY(0px);
            transition: transform 400ms;
            opacity: 1;
            z-index: 10;
        }
        
        .slidein-modal-close {
            position: absolute;
            top: 0;
            right: 10px;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 40px;
        }
        
    </style>
</head>

<body>

    <div class="reveal">
{*$page|print_r*}
        <!-- Any section element inside of this container is displayed as a slide -->
        <div class="slides">
{foreach item=slide from=$page.elements}
{if $slide.content|is_array}
            <section>
{foreach item=child from=$slide.content}
                <!-- child -->
                <section {foreach key=key item=item from=$child.attributes}{$key}="{$item}" {/foreach}>
                    {$child.content}
                </section>
                <!-- / child -->
{/foreach}
            </section>
{else}
            <section {foreach key=key item=item from=$slide.attributes}{$key}="{$item}" {/foreach}>
                {$slide.content}
            </section>
{/if}            
{/foreach}
        </div>
{* now check if we have to create any modal HTML *}

{* workaround to use hyphens in key for smarty *}
{assign var="dataTimelineSlidein" value="data-timeline-slidein"}
{*$child.attributes.$dataTimelineSlidein*}

{foreach item=slide from=$page.elements}
    {if $slide.content|is_array}
        {foreach item=child from=$slide.content}
            {if isset($child.modal)}
            
        <div class="slidein-modal" id="{$child.attributes.$dataTimelineSlidein}" style="{include 'revealjs/tpl/snippet_styleModal.tpl'}">
            {if isset($child.modal.content)}{$child.modal.content}{/if}
        </div>
            {/if}
        {/foreach}
    {else}
        {if isset($slide.modal)}
        <div class="slidein-modal" id="{$slide.attributes.$dataTimelineSlidein}" style="{include 'revealjs/tpl/snippet_styleModal.tpl'}">
            {if isset($slide.modal.content)}{$slide.modal.content}{/if}
        </div>
        {/if}
    {/if}            
{/foreach}

    </div>
    
    <script src="{if isset($page.relPathPrefix)}{$page.relPathPrefix}{/if}vendor/revealjs/lib/js/head.min.js"></script>
    <script src="{if isset($page.relPathPrefix)}{$page.relPathPrefix}{/if}vendor/revealjs/js/reveal.js"></script>
    <script>
    </script>

    <script>
        {*// Full list of configuration options available at:
        // https://github.com/hakimel/reveal.js#configuration*}
{literal}
        Reveal.initialize({
{/literal}        
        	{if isset($page.reveal.coreControls)}controls: {$page.reveal.coreControls},{/if}

        	{if isset($page.reveal.coreProgress)}progress: {$page.reveal.coreProgress},{/if}

        	{if isset($page.reveal.coreHistory)}history: {$page.reveal.coreHistory},{/if}

        	{if isset($page.reveal.coreCenter)}center: {$page.reveal.coreCenter},{/if}

        	{if isset($page.reveal.coreSlideNumber)}slideNumber: {$page.reveal.coreSlideNumber},{/if}

        	{if isset($page.reveal.coreTransition)}transition: {$page.reveal.coreTransition},{/if}

{literal}

        	menu: {
                {/literal}{*// Specifies which side of the presentation the menu will 
        		// be shown. Use 'left' or 'right'.*}
        		{if isset($page.reveal.menuSide)}side: '{$page.reveal.menuSide}',{/if}
        		
        		{*// Add slide numbers to the titles in the slide list.
        		// Use 'true' or format string (same as reveal.js slide numbers)*}
        		{if isset($page.reveal.menuNumbers)}numbers: {$page.reveal.menuNumbers},{/if}
        
        		{*// Specifies which slide elements will be used for generating
        		// the slide titles in the menu. The default selects the first
        		// heading element found in the slide, but you can specify any
        		// valid css selector and the text from the first matching
        		// element will be used.
        		// Note: that a section data-menu-title attribute or an element
        		// with a menu-title class will take precedence over this option*}
        		{if isset($page.reveal.menuTitleSelector)}titleSelector: {$page.reveal.menuTitleSelector},{/if}
        
        		{*// Hide slides from the menu that do not have a title.
        		// Set to 'true' to only list slides with titles.*}
        		{if isset($page.reveal.menuHideMissingTitles)}hideMissingTitles: {$page.reveal.menuHideMissingTitles},{/if}
        
        		{*// Add markers to the slide titles to indicate the 
        		// progress through the presentation*}
        		{if isset($page.reveal.menuMarkers)}markers: {$page.reveal.menuMarkers},{/if}
        
        		{*// Specifies the themes that will be available in the themes
        		// menu panel. Set to 'false' to hide themes panel.*}
        		{if isset($page.reveal.menuThemes)}themes: {$page.reveal.menuThemes},{/if}
        
        		{*// Specifies if the transitions menu panel will be shown.*}
        		{if isset($page.reveal.menuTransitions)}transitions: {$page.reveal.menuTransitions},{/if}
        
        		{*// Adds a menu button to the slides to open the menu panel.
        		// Set to 'false' to hide the button.*}
        		{if isset($page.reveal.menuOpenButton)}openButton: {$page.reveal.menuOpenButton},{/if}
        
        		{*// If 'true' allows the slide number in the presentation to
        		// open the menu panel. The reveal.js slideNumber option must 
        		// be displayed for this to take effect*}
        		{if isset($page.reveal.menuOpenSlideNumber)}openSlideNumber: {$page.reveal.menuOpenSlideNumber},{/if}
        
        		{*// If true allows the user to open and navigate the menu using
        		// the keyboard. Standard keyboard interaction with reveal
        		// will be disabled while the menu is open.*}
        		{if isset($page.reveal.menuKeyboard)}keyboard: {$page.reveal.menuKeyboard},{/if}
        
        		{*// Normally the menu will close on user actions such as
        		// selecting a menu item, or clicking the presentation area.
        		// If 'true', the sticky option will leave the menu open
        		// until it is explicitly closed, that is, using the close
        		// button or pressing the ESC or m key (when the keyboard 
        		// interaction option is enabled).*}
        		{if isset($page.reveal.menuSticky)}sticky: {$page.reveal.menuSticky},{/if}
        
        		{*// If 'true' standard menu items will be automatically opened
        		// when navigating using the keyboard. Note: this only takes 
        		// effect when both the 'keyboard' and 'sticky' options are enabled.*}
        		{if isset($page.reveal.menuAutoOpen)}autoOpen: {$page.reveal.menuAutoOpen},{/if}
        		
        		{*// Specify custom panels to be included in the menu, by
        		// providing an array of objects with 'title', 'icon'
        		// properties, and either a 'src' or 'content' property.*}

{if isset($page.menuPanels)}
    {foreach item=panel from=$page.menuPanels}
        {if $panel@first}
        custom: [
        {/if}
            {literal}{{/literal} 
			             title: '{$panel.panelTitle}', 
			             icon: '<i class="fa fa-{$panel.panelIcon}">', 
			             src: '{$panel.panelUrl}'
			         {literal}}{/literal}{if $panel@last}
			         
			         ]{else},
			         {/if}
    {/foreach}
{/if}
{literal}
            },

            // Optional reveal.js plugins
            dependencies: [{
                src: '{/literal}{if isset($page.relPathPrefix)}{$page.relPathPrefix}{/if}{literal}vendor/revealjs/lib/js/classList.js',
                condition: function() {
                    return !document.body.classList;
                }
            }, {
                src: '{/literal}{if isset($page.relPathPrefix)}{$page.relPathPrefix}{/if}{literal}vendor/revealjs/plugin/markdown/markdown.js',
                condition: function() {
                    return !!document.querySelector('[data-markdown]');
                }
            }, {
                src: '{/literal}{if isset($page.relPathPrefix)}{$page.relPathPrefix}{/if}{literal}vendor/revealjs/plugin/background-youtube-video/background-youtube-video.js'
            }, {
                src: '{/literal}{if isset($page.relPathPrefix)}{$page.relPathPrefix}{/if}{literal}vendor/revealjs/plugin/timeline-slidein/timeline-slidein.js'
            }, {
                src: '{/literal}{if isset($page.relPathPrefix)}{$page.relPathPrefix}{/if}{literal}vendor/revealjs/plugin/zoom-js/zoom.js',
                async: true
            }, {
                src: '{/literal}{if isset($page.relPathPrefix)}{$page.relPathPrefix}{/if}{literal}vendor/revealjs/plugin/menu/menu.js',
                async: true
            }]
        });
    </script>
{/literal}

</body>

</html>