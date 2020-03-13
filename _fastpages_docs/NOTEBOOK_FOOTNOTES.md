# Detailed Guide To Footnotes in Notebooks

Notebook -> HTML Footnotes don't work the same as Markdown. There isn't a good solution, so made these Jekyll plugins as a workaround

```
This adds a linked superscript {% fn 15 %}

{{ "This is the actual footnote" | fndetail: 15 }}
```

![image](https://user-images.githubusercontent.com/1483922/76640645-83e49f80-650d-11ea-8f8a-01ee6eba91e1.png)

You can have links, but then you have to use **single quotes** to escape the link.  
```
This adds a linked superscript {% fn 20 %}

{{ 'This is the actual footnote with a [link](www.github.com) as well!'  | fndetail: 20 }}
```
![image](https://user-images.githubusercontent.com/1483922/76640916-f9e90680-650d-11ea-88e2-039394d741f7.png)

However, what if you want a single quote in your footnote?  There is not an easy way  to escape that.  Fortunately, you can use the special HTML character `&#39;` (you must keep the semicolon!).  For example, you can include a single quote like this:


```
This adds a linked superscript {% fn 20 %}

{{ 'This is the actual footnote; with a [link](www.github.com) as well! and a single quote &#39; too!'  | fndetail: 20 }}
```

![image](https://user-images.githubusercontent.com/1483922/76641725-45e87b00-650f-11ea-9bf3-6839717cac2a.png)
