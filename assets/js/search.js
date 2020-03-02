// 搜索功能
blog.addLoadEvent(function() {
    // 标题等信息
    var titles = []
    // 正文内容
    var contents = []
    // 上一次输入
    var keyBefore = ''
    // IOS 键盘中文输入bug
    var inputLock = false
    // 本地无缓存/站点重新编译，弹框阻塞，加载全文检索内容
    if (!localStorage.db || localStorage.dbVersion != blog.buildAt) {
      // 删除失效缓存
      if (localStorage.db) {
        localStorage.removeItem('db')
      }
      if (localStorage.dbVersion) {
        localStorage.removeItem('dbVersion')
      }
    //   var loadingDOM = document.querySelector('.page-search h1 img')
    //   loadingDOM.style.opacity = 1
  
      blog.ajax(
        {
          timeout: 20000,
          url: blog.baseurl + '/assets/xml/search.xml'
        },
        function(data) {
          localStorage.db = data
          localStorage.dbVersion = blog.buildAt
          initContentDB()
          search(document.querySelector('#search-input').value)
        //   if(loadingDOM.style){
        //     loadingDOM.style.opacity = 0
        //   }
        },
        function() {
          console.error('Full-text search data failed to load...')
        }
      )
    }
  
    if (localStorage.db) {
      initContentDB()
    }
    document.querySelectorAll('.list-search .title').forEach(function(title) {
      titles.push(title.innerHTML)
    })
  
    function initContentDB() {
      var root = document.createElement('div')
      root.innerHTML = localStorage.db
      root.querySelectorAll('li').forEach(function(content) {
        var str = content.innerHTML
        contents.push(str)
      })
    }
  
    function search(key) {
      key = blog.trim(key)
      if (key == keyBefore) {
        return
      }
      // <>& 替换
      key = key.replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/&/g, '&amp;')
  
      keyBefore = key
      var doms = document.querySelectorAll('.list-search li')
      var h1 = '<span class="hint">'
      var h2 = '</span>'
      for (let i = 0; i < doms.length; i++) {
        var title = titles[i]
        var content = contents[i]
        var dom_li = doms[i]
        var dom_title = dom_li.querySelector('.title')
        var dom_content = dom_li.querySelector('.content')
  
        dom_title.innerHTML = title
        dom_content.innerHTML = ''
  
        // 空字符隐藏
        if (key == '') {
          dom_li.setAttribute('hidden', true)
          continue
        }
        var hide = true
        var r1 = new RegExp(blog.encodeRegChar(key), 'gi')
        var r2 = new RegExp(blog.encodeRegChar(key), 'i')
  
        // 标题全局替换
        if (r1.test(title)) {
          hide = false
          dom_title.innerHTML = title.replace(r1, h1 + key + h2)
        }
        // 内容先找到第一个，然后确定100个字符，再对这100个字符做全局替换
        var cResult = r2.exec(content)
        if (cResult) {
          hide = false
          index = cResult.index
          var leftShifting = 10
          var left = index - leftShifting
          var right = index + (100 - leftShifting)
          if (left < 0) {
            right = right - left
          }
          content = content.substring(left, right)
          dom_content.innerHTML = content.replace(r1, h1 + key + h2) + '...'
        }
        // 内容未命中标题命中，内容直接展示前100个字符
        if (!cResult && !hide && content) {
          dom_content.innerHTML = content.substring(0, 100) + '...'
        }
        if (hide) {
          dom_li.setAttribute('hidden', true)
        } else {
          dom_li.removeAttribute('hidden')
        }
      }
    }
  
    var input = document.getElementById('search-input')
    blog.addEvent(input, 'input', function(event) {
      if (!inputLock) {
        search(event.target.value)
      }
    })
    blog.addEvent(input, 'compositionstart', function(event) {
      inputLock = true
    })
    blog.addEvent(input, 'compositionend', function(event) {
      inputLock = false
      search(event.target.value)
    })
  })