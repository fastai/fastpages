// 打印主题标识,请保留出处
;(function() {
    var style1 = 'background:#4BB596;color:#ffffff;border-radius: 2px;'
    var style2 = 'color:#000000;'
    var author = ' TMaize'
    var github = ' https://github.com/TMaize/tmaize-blog'
    var build = ' ' + blog.buildAt
    console.info('%c Theme Author %c' + author, style1, style2)
    console.info('%c Theme GitHub %c' + github, style1, style2)
    console.info('%c Site  Build  %c' + build, style1, style2)
  })()
  
  /**
   * 工具，允许多次onload不被覆盖
   * @param {方法} func
   */
  blog.addLoadEvent = function(func) {
    var oldonload = window.onload
    if (typeof window.onload != 'function') {
      window.onload = func
    } else {
      window.onload = function() {
        oldonload()
        func()
      }
    }
  }
  
  /**
   * 工具，兼容的方式添加事件
   * @param {单个DOM节点} dom
   * @param {事件名} eventName
   * @param {事件方法} func
   * @param {是否捕获} useCapture
   */
  blog.addEvent = function(dom, eventName, func, useCapture) {
    if (window.attachEvent) {
      dom.attachEvent('on' + eventName, func)
    } else if (window.addEventListener) {
      if (useCapture != undefined && useCapture === true) {
        if(dom){
            dom.addEventListener(eventName, func, true)
        }
      } else {
        if(dom){
            dom.addEventListener(eventName, func, false)
        }
      }
    }
  }
  
  /**
   * 工具，DOM添加某个class
   * @param {单个DOM节点} dom
   * @param {class名} className
   */
  blog.addClass = function(dom, className) {
    if (!blog.hasClass(dom, className)) {
      if(dom){
      var c = dom.className || ''
      dom.className = c + ' ' + className
      dom.className = blog.trim(dom.className)
      }
    }
  }
  
  /**
   * 工具，DOM是否有某个class
   * @param {单个DOM节点} dom
   * @param {class名} className
   */
  blog.hasClass = function(dom, className) {
    if(! dom) {
        return false
    }
    var list = (dom.className || '').split(/\s+/)
    for (var i = 0; i < list.length; i++) {
      if (list[i] == className) return true
    }
    return false
  }
  
  /**
   * 工具，DOM删除某个class
   * @param {单个DOM节点} dom
   * @param {class名} className
   */
  blog.removeClass = function(dom, className) {
    if (blog.hasClass(dom, className)) {
      var list = (dom.className || '').split(/\s+/)
      var newName = ''
      for (var i = 0; i < list.length; i++) {
        if (list[i] != className) newName = newName + ' ' + list[i]
      }
      dom.className = blog.trim(newName)
    }
  }
  
  /**
   * 工具，DOM切换某个class
   * @param {单个DOM节点} dom
   * @param {class名} className
   */
  blog.toggleClass = function(dom, className) {
    if (blog.hasClass(dom, className)) {
      blog.removeClass(dom, className)
    } else {
      if(dom){
        blog.addClass(dom, className)
      }
    }
  }
  
  /**
   * 工具，兼容问题，某些OPPO手机不支持ES5的trim方法
   * @param {字符串} str
   */
  blog.trim = function(str) {
    return str.replace(/^\s+|\s+$/g, '')
  }
  
  /**
   * 工具，转义html字符
   * @param {字符串} str
   */
  blog.htmlEscape = function(str) {
    var temp = document.createElement('div')
    temp.innerText = str
    str = temp.innerHTML
    temp = null
    return str
  }
  
  /**
   * 工具，转换实体字符防止XSS
   * @param {字符串} str
   */
  blog.encodeHtml = function(html) {
    var o = document.createElement('div')
    o.innerText = html
    var temp = o.innerHTML
    o = null
    return temp
  }
  
  /**
   * 工具， 转义正则关键字
   * @param {字符串} str
   */
  blog.encodeRegChar = function(str) {
    // \ 必须在第一位
    var arr = ['\\', '.', '^', '$', '*', '+', '?', '{', '}', '[', ']', '|', '(', ')']
    arr.forEach(function(c) {
      var r = new RegExp('\\' + c, 'g')
      str = str.replace(r, '\\' + c)
    })
    return str
  }
  
  /**
   * 工具，Ajax
   * @param {字符串} str
   */
  blog.ajax = function(option, success, fail) {
    var xmlHttp = null
    if (window.XMLHttpRequest) {
      xmlHttp = new XMLHttpRequest()
    } else {
      xmlHttp = new ActiveXObject('Microsoft.XMLHTTP')
    }
    var url = option.url
    var method = (option.method || 'GET').toUpperCase()
    var sync = option.sync === false ? false : true
    var timeout = option.timeout || 10000
  
    var timer
    var isTimeout = false
    xmlHttp.open(method, url, sync)
    xmlHttp.onreadystatechange = function() {
      if (isTimeout) {
        fail({
          error: '请求超时'
        })
      } else {
        if (xmlHttp.readyState == 4) {
          if (xmlHttp.status == 200) {
            success(xmlHttp.responseText)
          } else {
            fail({
              error: '状态错误',
              code: xmlHttp.status
            })
          }
          //清除未执行的定时函数
          clearTimeout(timer)
        }
      }
    }
    timer = setTimeout(function() {
      isTimeout = true
      fail({
        error: '请求超时'
      })
      xmlHttp.abort()
    }, timeout)
    xmlHttp.send()
  }
  
  /**
   * 特效：点击页面文字冒出特效
   */
  blog.initClickEffect = function(textArr) {
    function createDOM(text) {
      var dom = document.createElement('span')
      dom.innerText = text
      dom.style.left = 0
      dom.style.top = 0
      dom.style.position = 'fixed'
      dom.style.fontSize = '12px'
      dom.style.whiteSpace = 'nowrap'
      dom.style.webkitUserSelect = 'none'
      dom.style.userSelect = 'none'
      dom.style.opacity = 0
      dom.style.transform = 'translateY(0)'
      dom.style.webkitTransform = 'translateY(0)'
      return dom
    }
  
    blog.addEvent(window, 'click', function(ev) {
      var tagName = ev.target.tagName.toLocaleLowerCase()
      if (tagName == 'a') {
        return
      }
      var text = textArr[parseInt(Math.random() * textArr.length)]
      var dom = createDOM(text)
  
      document.body.appendChild(dom)
      var w = parseInt(window.getComputedStyle(dom, null).getPropertyValue('width'))
      var h = parseInt(window.getComputedStyle(dom, null).getPropertyValue('height'))
  
      var sh = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0
      dom.style.left = ev.pageX - w / 2 + 'px'
      dom.style.top = ev.pageY - sh - h + 'px'
      dom.style.opacity = 1
  
      setTimeout(function() {
        dom.style.transition = 'transform 500ms ease-out, opacity 500ms ease-out'
        dom.style.webkitTransition = 'transform 500ms ease-out, opacity 500ms ease-out'
        dom.style.opacity = 0
        dom.style.transform = 'translateY(-26px)'
        dom.style.webkitTransform = 'translateY(-26px)'
      }, 20)
  
      setTimeout(function() {
        document.body.removeChild(dom)
        dom = null
      }, 520)
    })
  }
  
  // 新建DIV包裹TABLE
  blog.addLoadEvent(function() {
    // 文章页生效
    if (document.getElementsByClassName('page-post').length == 0) {
      return
    }
    var tables = document.getElementsByTagName('table')
    for (var i = 0; i < tables.length; i++) {
      var table = tables[i]
      var elem = document.createElement('div')
      elem.setAttribute('class', 'table-container')
      table.parentNode.insertBefore(elem, table)
      elem.appendChild(table)
    }
  })
  
  // 回到顶部
  blog.addLoadEvent(function() {
    var toTopDOM = document.getElementById('to-top')
  
    function getScrollTop() {
      if (document.documentElement && document.documentElement.scrollTop) {
        return document.documentElement.scrollTop
      } else if (document.body) {
        return document.body.scrollTop
      }
    }
    function scrollTo(top) {
      if (document.documentElement && document.documentElement.scrollTop) {
        document.documentElement.scrollTop = parseInt(top) || 0
      } else if (document.body) {
        document.body.scrollTop = parseInt(top) || 0
      }
    }
  
    blog.addEvent(window, 'scroll', function() {
      if (getScrollTop() > 200) {
        blog.addClass(toTopDOM, 'show')
      } else {
        blog.removeClass(toTopDOM, 'show')
      }
    })
  
    blog.addEvent(toTopDOM, 'click', function(event) {
      event.stopPropagation()
      blog.removeClass(toTopDOM, 'show')
      scrollTo(0)
    })
  })