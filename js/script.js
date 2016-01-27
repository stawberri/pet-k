(function(){var t=this;this.puddi=function(e){return t.puddi.mew.push(e)},this.puddi.mew=[]}).call(this);
(function(){puddi(function(){})}).call(this);
(function(){puddi(function(){return this.$=new Barn(localStorage)})}).call(this);
(function(){puddi(function(){var t,e=this;return this.stage=new createjs.Stage("game"),t=createjs.Ticker,t.timingMode=t.RAF_SYNCHED,t.addEventListener("tick",function(t){return e.stage.update(t)}),t})}).call(this);
(function(){puddi(function(){var t,e,i,n;return t=e=new createjs.Container,t.x=480,t.y=270,this.stage.addChild(e),i=n=new createjs.Bitmap("img/bg/city-water.jpg"),i.regX=640,i.regY=360,e.addChild(n)})}).call(this);
(function(){puddi(function(){var t,e;return t=e=new createjs.Sprite(new createjs.SpriteSheet({images:["img/k/0.png","img/k/1.png","img/k/2.png"],frames:{width:368,height:492},animations:{idle:0,alert:1,exclaim:2}})),t.x=69,t.y=49,this.stage.addChild(e)})}).call(this);
(function(){var t,e,i,n,r;for(t={_:this},e=0,r=(n=this.puddi.mew).length;r>e;++e)i=n[e],i.call(t,t)}).call(this);
