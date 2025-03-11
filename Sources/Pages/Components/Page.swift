import ConcurrencyExtras
import Dependencies
import HTML
import Hummingbird
import Vue

public protocol Page: Sendable, HTMLDocument, ResponseGenerator {
  var title: String { get }
  var lang: String { get }

  var chunkSize: Int { get }
  var headers: HTTPFields { get }
}

extension Page {
  public var lang: String { "en" }
  public var chunkSize: Int { 1024 }
  public var headers: HTTPFields { [.contentType: "text/html; charset=utf-8"] }

  public static func _render<Output: HTMLByteStream>(
    _ document: consuming Self,
    into output: inout Output
  ) {
    withDependencies {
      $0.ssg = .class
    } operation: {
      BaseLayout._render(
        BaseLayout(
          head: {
            meta(.charset(.utf8))
            tag("title") { document.title }
            meta(.name("viewport"), .content("width=device-width, initial-scale=1.0"))
            style {
              "/*! modern-normalize v3.0.1 | MIT License | https://github.com/sindresorhus/modern-normalize */*,::after,::before{box-sizing:border-box}html{font-family:system-ui,'Segoe UI',Roboto,Helvetica,Arial,sans-serif,'Apple Color Emoji','Segoe UI Emoji';line-height:1.15;-webkit-text-size-adjust:100%;tab-size:4}body{margin:0}b,strong{font-weight:bolder}code,kbd,pre,samp{font-family:ui-monospace,SFMono-Regular,Consolas,'Liberation Mono',Menlo,monospace;font-size:1em}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}table{border-color:currentcolor}button,input,optgroup,select,textarea{font-family:inherit;font-size:100%;line-height:1.15;margin:0}[type=button],[type=reset],[type=submit],button{-webkit-appearance:button}legend{padding:0}progress{vertical-align:baseline}::-webkit-inner-spin-button,::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;outline-offset:-2px}::-webkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}summary{display:list-item}"
            }
            style {
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
                height: 100%;
              }
              body {
                background-color: #1c1c1c;
                color: #fafafa;
                height: 100%;
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
                font-feature-settings: "ss03", "ss04", "ss05";
                line-height: 1;
              }
              [v-cloak] {
                display: none;
              }
              """
            }
            /// Xcode Styling
            style {
              ".xml .hljs-meta{color:#6C7986}.hljs-comment,.hljs-quote{color:#6C7986}.hljs-tag,.hljs-attribute,.hljs-keyword,.hljs-selector-tag,.hljs-literal,.hljs-name{color:#FC5FA3}.hljs-variable,.hljs-template-variable{color:#FC5FA3}.hljs-code,.hljs-string,.hljs-meta-string{color:#FC6A5D}.hljs-regexp,.hljs-link{color:#5482FF}.hljs-title,.hljs-symbol,.hljs-bullet,.hljs-number{color:#41A1C0}.hljs-section,.hljs-meta{color:#FC5FA3}.hljs-class .hljs-title,.hljs-type,.hljs-built_in,.hljs-builtin-name,.hljs-params{color:#D0A8FF}.hljs-attr{color:#BF8555}.hljs-subst{color:#FFF}.hljs-formula{font-style:italic}.hljs-selector-id,.hljs-selector-class{color:#9b703f}.hljs-doctag,.hljs-strong{font-weight:bold}.hljs-emphasis{font-style:italic}"
            }
            script(
              .src("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"),
              .defer
            )
            script(
              .src(
                "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/swift.min.js"),
              .defer
            )
            script(
              .src(
                "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/rust.min.js"),
              .defer
            )
            script(
              .src(
                "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/javascript.min.js"
              ),
              .defer
            )
            script(
              .src(
                "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/typescript.min.js"
              ),
              .defer
            )
            script(.type(.module)) { "hljs.highlightAll();" }

            document.head
          },
          body: {
            document.body
              .inlineStyle("font-optical-sizing", "auto")
              .inlineStyle("font-size", "0.7em")
              .inlineStyle("font-size", "0.8em", media: .minWidth(390))
              .inlineStyle("font-size", "0.9em", media: .minWidth(480))
              .attribute("lang", value: document.lang)

            script(.type(.module), .defer) {
              """
              import { createApp } from "https://unpkg.com/petite-vue@0.4.1/dist/petite-vue.es.js";
              createApp().mount();
              """
            }
          }
        ),
        into: &output
      )
    }
  }
}

private struct BaseLayout<Head: HTML, Body: HTML>: HTMLDocument {
  var head: Head
  var body: Body

  init(
    @HTMLBuilder head: () -> Head,
    @HTMLBuilder body: () -> Body
  ) {
    self.head = head()
    self.body = body()
  }
}
