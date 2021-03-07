pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--frogs
--by carnivaltears
function _init()
	map_size=64
	tile_size=8
	map_end=map_size*tile_size
	create_map(map_size)
	create_player(0,0)
	cam_x=0
	cam_y=0
	turn=0
end

function _update()
	if btnp()!=0 then
		update_player()
		update_camera()
		turn+=1
	end
end

function update_camera()
	cam_x=(p.x*tile_size)-64+(tile_size/2)
	cam_y=(p.y*tile_size)-64+(tile_size/2)
	cam_x=mid(0,cam_x,map_end-128)
	cam_y=mid(0,cam_y,map_end-128)
	camera(cam_x,cam_y)
end

function _draw()
 cls()
	draw_map()
	draw_player()
	print(turn,cam_x,cam_y)
end
-->8
--player
function create_player(x,y)
	p={}
	p.x=x
	p.y=x
	p.v_spr=4
	p.h_spr=5
	p.dir=1
end

function update_player()
	if btnp(⬆️) then
		p.y-=1
		p.dir=1
	elseif btnp(➡️) then
		p.x+=1
		p.dir=2
	elseif btnp(⬇️) then
		p.y+=1
		p.dir=3
	elseif btnp(⬅️) then
		p.x-=1
		p.dir=4
	end
	p.x=mid(0,p.x,map_size-1)
	p.y=mid(0,p.y,map_size-1)
end

function draw_player()
	local x=p.x*tile_size
	local y=p.y*tile_size
	if p.dir==1 then
		spr(p.v_spr,x,y)
	elseif p.dir==2 then
		spr(p.h_spr,x,y)
	elseif p.dir==3 then
		spr(p.v_spr,x,y,1,1,false,true)
	else
		spr(p.h_spr,x,y,1,1,true,false)
	end
end
-->8
--map
function create_map(size)
	m={}
	for x=0,size-1 do
		m[x]={}
		for y=0,size-1 do
			local terrain=flr(rnd(4))
			if terrain==0 then
				m[x][y]={t="land",s=20}
			elseif terrain==1 then
				m[x][y]={t="land",s=21}
			else
				m[x][y]={t="land",s=22}
			end
		end
	end
	
	generate_lakes()
	
	for i=0,(size/2) do
		generate_lily()
	end
end

function generate_lakes()
	
end

function generate_lily()
	local x=flr(rnd(#m))
	local y=flr(rnd(#m))
	if m[x][y].t=="water" and
				m[x+1][y].t=="water" and
				m[x][y+1].t=="water" and
				m[x+1][y+1].t=="water" then
		m[x][y]={t="lily",s=2}
		m[x+1][y]={t="lily",s=3}
		m[x][y+1]={t="lily",s=18}
		m[x+1][y+1]={t="lily",s=19}
	end
end

function draw_map()
	for x=0,#m do
		for y=0,#m[x] do
			spr(m[x][y].s,x*8,y*8)
		end
	end
end
__gfx__
00000000cccccccccccccccccccccccc001331000000003000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cc7c7ccccccccccccccccccc303bb3033330030000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700c7c7cccccccccbbbbbbbcccc03bbbb3000333b3100000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000cccccccccccbbbbbbbb3cccc003bb300003bbbb300000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000ccccccccccbbbbbbbb3ccccc003bb300003bbbb300000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700cccc7c7cccbbbbbbb3cccccc0333333000333b3100000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ccc7c7ccc3bbbbbb3ccccccc030000303330030000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ccccccccc3bbbbbbbbbbbbbc030000300000003000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ccccccccc3bbbbbbbbbbbbbc555555555555556555555555000000000000000000000000000000000000000000000000000000000000000000000000
00000000ccccccccc3bbbbbbbbbbbbbc55555b5b5555555555555555000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccccc3bbbbbbbbbbbcc555555b55556555555555555000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccccc3bbbbbbbbbbbcc55b555b55555565555555555000000000000000000000000000000000000000000000000000000000000000000000000
00000000ccccccccccc33bbbbbbbbcccb5b555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000
00000000ccccccccccccc333333ccccc5b55b5555655555555555555000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccccccccccccccccccc5b555b555555655555555555000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccccccccccccccccccc55555b555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000
