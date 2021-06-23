-- Perfgraph for PICO-8

_p_perf={}
_p_pfo={}

function p_start(name,col)
	if col==nil then
		col=rnd()*15+1
	end

	local pp=_p_perf[name]
	if pp==nil then
		pp={}
		pp.col=col
		pp.ct=0
		_p_perf[name]=pp
	end

	if pp.q!=true then
		add(_p_pfo, name)
		pp.q=true
	end
	
	pp.st=stat(1)
end

function p_end(name)
	local pp=_p_perf[name]
	if pp then
		pp.ct+=max(stat(1)-pp.st,0)
	end
end

function p_show(x,y,w,compact)
	camera()
	clip()
	fillp()
	for n in all(_p_pfo) do
		local tp=_p_perf[n]
		local pw=tp.ct*w
		local p=flr((tp.ct*100)+0.5)
		
		if compact then
			rectfill(x,y,x+w,y+4,0)
			rectfill(x,y,x+pw,y+4,tp.col)
			print(n..":"..p.."%",x+pw+2,y,7)
			y+=4+2
		else
			rectfill(x,y,x+w,y+4,0)
			rectfill(x,y,x+pw,y+4,tp.col)
			local lab=n..":"..p.."%"
			rectfill(x+w+2,y,x+w+2+#lab*4,y+4,1)
			print(lab,x+w+2,y,7)
			y+=4+2
		end

		tp.q=false
		tp.ct=0
	end
	
	_p_pfo={}
end