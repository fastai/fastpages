{%- extends 'hide.tpl' -%}
{%- block body -%}
{%- set internals = ["metadata", "output_extension", "inlining", 
                    "raw_mimetypes", "global_content_filter"] -%}
---
{%- for k in resources |reject("in", internals) %}
{{ k }}: {{ resources[k] }}
{%- endfor %}
---
{% include 'autogen.tpl' %}

<div class="container" id="notebook-container">
        {{ super()  }}
</div>
{%- endblock body %}