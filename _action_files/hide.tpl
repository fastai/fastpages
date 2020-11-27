{%- extends 'basic.tpl' -%}

{% block codecell %}
    {{ "{% raw %}" }}
    {{ super() }}
    {{ "{% endraw %}" }}
{% endblock codecell %}

{% block input_group -%}
{%- if cell.metadata.collapse_show -%}
    <details class="description" open>
      <summary class="btn btn-sm" data-open="Hide Code" data-close="Show Code"></summary>
        <p>{{ super() }}</p>
    </details>
{%- elif cell.metadata.collapse_hide -%}
    <details class="description">
      <summary class="btn btn-sm" data-open="Hide Code" data-close="Show Code"></summary>
        <p>{{ super() }}</p>
    </details>
{%- elif cell.metadata.hide_input or nb.metadata.hide_input -%}
{%- else -%}
    {{ super()  }}
{%- endif -%}
{% endblock input_group %}

{% block output_group -%}
{%- if cell.metadata.collapse_output -%}
    <details class="description">
      <summary class="btn btn-sm" data-open="Hide Output" data-close="Show Output"></summary>
        <p>{{ super() }}</p>
    </details>
{%- elif cell.metadata.hide_output -%}
{%- else -%}
    {{ super()  }}
{%- endif -%}
{% endblock output_group %}

{% block output_area_prompt %}
{%- if cell.metadata.hide_input or nb.metadata.hide_input -%}
   <div class="prompt"> </div>
{%- else -%}
    {{ super()  }}
{%- endif -%}
{% endblock output_area_prompt %}