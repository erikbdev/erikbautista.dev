import Elementary

struct BaseStylings: HTML {
  var content: some HTML {
    /// Normalise
    style { HTMLRaw("/*! modern-normalize v3.0.1 | MIT License | https://github.com/sindresorhus/modern-normalize */*,::after,::before{box-sizing:border-box}html{font-family:system-ui,'Segoe UI',Roboto,Helvetica,Arial,sans-serif,'Apple Color Emoji','Segoe UI Emoji';line-height:1.15;-webkit-text-size-adjust:100%;tab-size:4}body{margin:0}b,strong{font-weight:bolder}code,kbd,pre,samp{font-family:ui-monospace,SFMono-Regular,Consolas,'Liberation Mono',Menlo,monospace;font-size:1em}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}table{border-color:currentcolor}button,input,optgroup,select,textarea{font-family:inherit;font-size:100%;line-height:1.15;margin:0}[type=button],[type=reset],[type=submit],button{-webkit-appearance:button}legend{padding:0}progress{vertical-align:baseline}::-webkit-inner-spin-button,::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;outline-offset:-2px}::-webkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}summary{display:list-item}") }
    style {
      HTMLRaw(
        """
        @font-face {
          font-family: "CommitMono";
          src: url("https://raw.githubusercontent.com/eigilnikolajsen/commit-mono/ecd81cdbd7f7eb2acaaa2f2f7e1a585676f9beff/src/fonts/fontlab/CommitMonoV143-VF.woff2");
          font-style: normal;
          font-weight: 400;
          font-display: swap;
        }
        html {
          line-height: 1.5;
        }
        pre a {
          text-decoration: none;
        }
        h1, h2, h3, h4, h5, figure, p, ol, ul, pre {
          margin: 0;
        }
        ol[role="list"], ul[role="list"] {
          list-style: none;
          padding-inline: 0;
        }
        img, video {
          display: block;
          max-inline-size: 100%;
        }
        code {
          font-family: "CommitMono", monospace;
          font-feature-settings", "ss03", "ss04", "ss05";
          line-height: 1;
        }
        """
      )
    }
  }
}