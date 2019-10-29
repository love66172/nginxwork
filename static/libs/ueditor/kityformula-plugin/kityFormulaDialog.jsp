<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" href="kityformula/assets/styles/base.css">
    <link rel="stylesheet" href="kityformula/assets/styles/ui.css">
    <link rel="stylesheet" href="kityformula/assets/styles/scrollbar.css">
    <style>
        html, body {
            padding: 0;
            margin: 0;
        }
        .kf-editor {
            width: 780px;
            height: 380px;
        }
        #loading {
            height: 32px;
            width: 340px;
            line-height: 32px;
            position: absolute;
            top: 42%;
            left: 50%;
            margin-left: -170px;
            font-family: arial, "Hiragino Sans GB", "Microsoft YaHei", "WenQuanYi Micro Hei", sans-serif;
        }
        #loading img {
            position: absolute;
        }
        #loading p {
            display: block;
            position: absolute;
            left: 40px;
            top: 0px;
            margin: 0;
        }

    </style>
    <title></title>
</head>
<body>
<div id="kfEditorContainer" class="kf-editor">
    <div id="tips" class="tips">
        sorry! Beta版本仅支持IE9及以上版本的浏览器，正式版本将会支持低版本浏览器，谢谢您的关注！
    </div>
</div>
<!--页面中一定要引入internal.js为了能直接使用当前打开dialog的实例变量-->
<!--internal.js默认是放到dialogs目录下的-->
<script type="text/javascript" src="../dialogs/internal.js"></script>

<script src="kityformula/js/jquery-1.11.0.min.js"></script>
<script src="kityformula/js/kitygraph.all.js"></script>
<script src="kityformula/js/kity-formula-render.all.js"></script>
<script src="kityformula/js/kity-formula-parser.all.min.js"></script>
<script src="kityformula/js/kityformula-editor.all.min.js"></script>
<script>
    jQuery( function ($) {

        if ( document.body.addEventListener ) {

            $( "#tips").html('<div id="loading"><img src="kityformula/loading.gif" alt="loading" /><p>正在加载，请耐心等待...</p></div>' );

            var factory = kf.EditorFactory.create( $( "#kfEditorContainer" )[ 0 ], {
                render: {
                    fontsize: 24
                },
                resource: {
                    path: "./kityformula/resource/"
                }
            } );

            factory.ready( function ( KFEditor ) {

                $( "#tips").remove();

                // this指向KFEditor
                var rng = editor.selection.getRange(),
                    img = rng.getClosedNode(),
                    imgLatex = img && $(img).attr('data-latex');

                this.execCommand( "render", imgLatex || "\\placeholder" );
                this.execCommand( "focus" );

                window.kfe = this;

            } );

            dialog.onok = function(){
                kfe.execCommand('get.image.data', function(data){
                    var latex = kfe.execCommand('get.source');
                    editor.execCommand('inserthtml', '<img class="kfformula" src="'+ data.img +'" data-latex="' + latex + '" />');
                    dialog.close();
                });

                return false;
            }

        } else {
            $( "#tips").css( "color", "black" );
            $( "#tips").css( "padding", "10px" );
        }

    } );
</script>
</body>
</html>