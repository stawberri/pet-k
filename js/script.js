(function(){var t=this;this.puddi=function(i){return t.puddi.mew.push(i)},this.puddi.mew=[]}).call(this);
(function(){puddi(function(){})}).call(this);
(function(){puddi(function(){return this.$=new Barn(localStorage)})}).call(this);
(function(){puddi(function(){var t,i=this;return this.stage=new createjs.Stage("game"),t=createjs.Ticker,t.timingMode=t.RAF_SYNCHED,t.addEventListener("tick",function(t){return i.stage.update(t)}),t})}).call(this);
(function(){puddi(function(){var t,i,e,n;return t=i=new createjs.Container,t.x=480,t.y=270,this.stage.addChild(i),e=n=new createjs.Bitmap("img/bg/city-water.jpg"),e.regX=640,e.regY=360,i.addChild(n)})}).call(this);
(function(){puddi(function(){var t,i;return t=i=new createjs.Sprite(new createjs.SpriteSheet({images:["img/k/0.png","img/k/1.png","img/k/2.png"],frames:{width:368,height:492},animations:{idle:0,alert:1,exclaim:2}})),t.x=69,t.y=49,this.stage.addChild(i)})}).call(this);
(function(){var t,i,e,n,a;for(t={_:require("prelude-ls")},i=0,a=(n=this.puddi.mew).length;a>i;++i)e=n[i],e.call(t,t)}).call(this);
