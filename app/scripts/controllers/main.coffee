# main.coffee



angular.module('angularYeomanApp')
  .controller('MainCtrl', ($scope, hudlayout_res) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ]
    $scope.hudlayout_res = hudlayout_res

    xposToNum = (pos='0') ->
      if pos[0] is 'r'
        return 640 - (+pos.substring(1))
      if pos[0] is 'c'
        return 320 + (+pos.substring(1))
      if pos[0] is 'f' # ???? f0 seems to be 'autofit'
        return 10
      return +pos

    yposToNum = (pos='0') ->
      if pos[0] is 'r'
        return 480 - (+pos.substring(1))
      if pos[0] is 'c'
        return 240 + (+pos.substring(1))
      if pos[0] is 'f' # ????
        return 10
      return +pos

    editor = new fabric.Canvas 'editor'
    window.editor = editor
    hl = hudlayout_res['Resource/HudLayout.res']
    getListener = ->
      _args = arguments
      ()-> console.log.apply(console, _args); return
    for key in Object.keys(hl)#[10..20]
      obj = hl[key]
      rect =
        left: xposToNum obj.xpos
        top: yposToNum obj.ypos
        width: xposToNum obj.wide
        height: yposToNum obj.tall
        opacity: 0.2
        fill: 'black'
        hasRotatingPoint: false
        # lockScalingY: true
        # lockScalingX: true
      rect.left += rect.width / 2
      rect.top += rect.height / 2
      # console.log rect, obj.fieldName
      # console.log obj
      if rect.width >= 640 or rect.height >= 480
        continue
      r = new fabric.Rect rect
      r.on('selected', getListener obj, rect, r)
      # r._obj = obj
      editor.add(r)
    # editor.on('object:selected')
    return
  )

# ["_invokeQueue",
#  "_runBlocks",
#  "requires",
#  "name",
#  "provider",
#  "factory",
#  "service",
#  "value",
#  "constant",
#  "filter",
#  "controller",
#  "directive",
#  "config",
#  "run"]