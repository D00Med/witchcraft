--scrolls

minetest.register_craftitem("witchcraft:scroll_day", {
		 description = "Scroll of day",
		 inventory_image = "witchcraft_scroll.png^witchcraft_sun_over.png",
		 stack_max = 1,
		 on_use = function(item)
			 minetest.set_timeofday(0.5)
			 item:take_item()
			 return item
		 end,
})

minetest.register_craftitem("witchcraft:scroll_night", {
		description = "Scroll of night",
		inventory_image = "witchcraft_scroll.png^witchcraft_moon_over.png",
		stack_max = 1,
		on_use = function(item)
			minetest.set_timeofday(0)
			item:take_item()
			return item
		end,
})

if minetest.get_modpath("pmobs")then
	minetest.register_craftitem("witchcraft:scroll_wild", {
		description = "Scroll of Wild",
		inventory_image = "witchcraft_scroll.png^witchcraft_dark_over.png",
		stack_max = 1,
		on_use = function(item, placer)
			local pos = placer:get_pos()
			minetest.add_entity(pos, "pmobs:dog")
			item:take_item()
			return item
		end,
	})
end

minetest.register_craftitem("witchcraft:scroll_fireball", {
		description = "Scroll of fireball",
		inventory_image = "witchcraft_scroll.png^witchcraft_fire_over.png",
		stack_max = 1,
		on_use = function(item, placer, pointed_thing)
			local dir = placer:get_look_dir()
			local playerpos = placer:get_pos()
			local entities = {}
			for i=1,4 do
				entities[i] = minetest.add_entity({
						x=playerpos.x+dir.x*1.5,
						y=playerpos.y+1.5+dir.y,
						z=playerpos.z+0+dir.z
					}, "witchcraft:fireball")
			end
			entities[2]:set_velocity({x=dir.x*7+0.5,y=dir.y*7,z=dir.z*7+0.5})
			entities[3]:set_velocity({x=dir.x*7-0.5,y=dir.y*7,z=dir.z*7-0.5})
			entities[4]:set_velocity({x=dir.x*7,y=dir.y*7-0.5,z=dir.z*7})
			entities[1]:set_velocity({x=dir.x*7,y=dir.y*7+0.5,z=dir.z*7})
			item:take_item()
			return item
		end,
})

if minetest.get_modpath("lightning") then
	minetest.register_craftitem("witchcraft:scroll_lightning", {
			description = "Scroll of lightning",
			inventory_image = "witchcraft_scroll.png^witchcraft_thunder_over.png",
			stack_max = 1,
			on_use = function(item, placer, pointed_thing)
				local playerpos = placer:get_pos()
				local dir = placer:get_look_dir()
				lightning.strike({x=playerpos.x+dir.x*2,y=playerpos.y+0+dir.y,z=playerpos.z+dir.z*2})
				item:take_item()
				return item
			end,
	})
end

minetest.register_craftitem("witchcraft:scroll_icicle", {
		description = "Scroll of icicle",
		inventory_image = "witchcraft_scroll.png^witchcraft_ice_over.png",
		stack_max = 1,
		on_use = function(item, placer, pointed_thing)
			local dir = placer:get_look_dir()
			local playerpos = placer:get_pos()
			local vec = {x=dir.x*7,y=dir.y*7,z=dir.z*7}
			local obj = minetest.add_entity({
					x=playerpos.x+dir.x*1.5,
					y=playerpos.y+1.5+dir.y,
					z=playerpos.z+0+dir.z
				}, "witchcraft:ice")
			local obj2 = minetest.add_entity({
					x=playerpos.x+dir.x*1.5,
					y=playerpos.y+1.5+dir.y,
					z=playerpos.z+1+dir.z
				}, "witchcraft:ice")
			local obj3 = minetest.add_entity({
					x=playerpos.x+1+dir.x*1.5,
					y=playerpos.y+1.5+dir.y,
					z=playerpos.z+0+dir.z
				}, "witchcraft:ice")
			obj:set_velocity(vec)
			obj2:set_velocity(vec)
			obj3:set_velocity(vec)
			item:take_item()
			return item
		end,
})

minetest.register_craftitem("witchcraft:scroll_nature", {
		description = "Scroll of nature",
		inventory_image = "witchcraft_scroll.png^witchcraft_leaf_over.png",
		stack_max = 1,
		on_use = function(item, placer, pointed_thing)
			local dir = placer:get_look_dir()
			local playerpos = placer:get_pos()
			local vec = {x=dir.x*6,y=dir.y*6,z=dir.z*6}
			local obj = minetest.add_entity({
					x=playerpos.x+dir.x*1.5,
					y=playerpos.y+1.5+dir.y,
					z=playerpos.z+0+dir.z
				}, "witchcraft:tree")
			obj:set_velocity(vec)
			item:take_item()
			return item
		end,
})

minetest.register_craftitem("witchcraft:scroll", {
		description = "Blank Scroll",
		inventory_image = "witchcraft_scroll.png",
})

minetest.register_craftitem("witchcraft:scroll_recipe", {
		description = "Recipe Scroll",
		inventory_image = "witchcraft_scroll.png^witchcraft_writing_over.png",
		on_use = function(itemstack, user, pointed_thing)									 
			local formspec = "size[10,9]"..
				"background[-0.6,-0.5;11.5,10.4;witchcraft_recipes.png]"											 
			minetest.show_formspec(user:get_player_name(), "witchcraft:scroll", formspec)	
		end,
})

if minetest.get_modpath("pmobs")then
	minetest.register_craft({
			output = 'witchcraft:scroll_wild',
			recipe = {
				{'mobs:meat_raw'},
				{'witchcraft:scroll'},
			}
	})
end

minetest.register_craft({
		output = 'witchcraft:scroll',
		recipe = {
			{'default:paper', 'default:paper', ''},
			{'default:paper', 'default:paper', ''},
		}
})

minetest.register_craft({
		output = 'witchcraft:scroll_recipe',
		recipe = {
			{'dye:black'},
			{'witchcraft:scroll'},
		}
})

minetest.register_craft({
		output = 'witchcraft:scroll_icicle',
		recipe = {
			{'default:ice'},
			{'default:diamond'},
			{'witchcraft:scroll'},
		}
})

minetest.register_craft({
		output = 'witchcraft:scroll_fireball',
		recipe = {
			{'default:obsidian_shard'},
			{'default:diamond'},
			{'witchcraft:scroll'},
		}
})

minetest.register_craft({
		output = 'witchcraft:scroll_nature',
		recipe = {
			{'default:leaves'},
			{'default:diamond'},
			{'witchcraft:scroll'},
		}
})

minetest.register_craft({
		output = 'witchcraft:scroll_day',
		recipe = {
			{'default:torch'},
			{'default:diamond'},
			{'witchcraft:scroll'},
		}
})

minetest.register_craft({
		output = 'witchcraft:scroll_night',
		recipe = {
			{'default:coal_lump'},
			{'default:diamond'},
			{'witchcraft:scroll'},
		}
})

minetest.register_craft({
		output = 'witchcraft:scroll_lightning',
		recipe = {
			{'default:steel_ingot'},
			{'default:diamond'},
			{'witchcraft:scroll'},
		}
})

--scroll powers

minetest.register_entity("witchcraft:fireball", {
		textures = {"tnt_boom.png"},
		velocity = 0.1,
		damage = 2,
		collisionbox = {0, 0, 0, 0, 0, 0},
		on_step = function(self, obj, pos)		
			local remove = minetest.after(2, function() 
					self.object:remove()
			end)
			local pos = self.object:get_pos()
			local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() then
					if obj:get_luaentity().name ~= "witchcraft:fireball"
						and obj:get_luaentity().name ~= "__builtin:item"
					and obj:get_luaentity().name ~= "gauges:hp_bar" then
						obj:punch(self.object, 1.0, {
								full_punch_interval=1.0,
								damage_groups={fleshy=3},
							}, nil)
						self.object:remove()
						return
					end
				end
			end
			for dx=0,1 do
				for dy=0,1 do
					for dz=0,1 do
						local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
						local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
						local n = minetest.get_node(p).name
						if n ~= "witchcraft:fireball" and n ~="default:dirt_with_grass" then	
							if minetest.registered_nodes[n].groups.flammable then
								minetest.set_node(t, {name="fire:basic_flame"})
								self.object:remove()
								return
							end
						end
					end
				end
			end

			local vec = self.object:get_velocity()
			minetest.add_particlespawner({
				amount = 6,
				time = 0.3,
				minpos = {x=pos.x-0.3, y=pos.y-0.3, z=pos.z-0.3},
				maxpos = {x=pos.x+0.3, y=pos.y+0.3, z=pos.z+0.3},
				minvel = {x=-0, y=-0, z=-0},
				maxvel = {x=0, y=0, z=0},
				minacc = {x=0,y=-0.5,z=0},
				maxacc = {x=-vec.x,y=-vec.y,z=-vec.z},
				minexptime = 0.1,
				maxexptime = 0.3,
				minsize = 1,
				maxsize = 2,
				collisiondetection = false,
				texture = "witchcraft_flame.png"
			})
		end,
})

minetest.register_entity("witchcraft:tree", {
		textures = {"witchcraft_skin.png"},
		velocity = 1,
		damage = 2,
		collisionbox = {0, 0, 0, 0, 0, 0},
		on_step = function(self, obj, pos)		
			local remove = minetest.after(2, function() 
					self.object:remove()
			end)
			local pos = self.object:get_pos()
			local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() then
					if obj:get_luaentity().name ~= "witchcraft:tree"
						and obj:get_luaentity().name ~= "__builtin:item"
					and obj:get_luaentity().name ~= "gauges:hp_bar" then
						obj:remove()
						default.grow_new_jungle_tree(pos)
						self.object:remove()
						return
					end
				end
			end
			
			local n = minetest.get_node(pos).name
			if n ~= "witchcraft:tree" and n ~="air" then	
				default.grow_new_jungle_tree(pos)
				self.object:remove()
			end

			minetest.add_particlespawner({
				amount = 6,
				time = 0.3,
				minpos = {x=pos.x-0.3, y=pos.y-0.3, z=pos.z-0.3},
				maxpos = {x=pos.x+0.3, y=pos.y+0.3, z=pos.z+0.3},
				minvel = {x=-0, y=-0, z=-0},
				maxvel = {x=0, y=0, z=0},
				minacc = {x=0,y=-0.5,z=0},
				maxacc = {x=0.5,y=0.5,z=0.5},
				minexptime = 0.1,
				maxexptime = 0.3,
				minsize = 1,
				maxsize = 2,
				collisiondetection = false,
				texture = "witchcraft_leaf_over.png"
			})
		end,
})

minetest.register_entity("witchcraft:ice", {
		visual="sprite",
		visual_size={x=1,y=1},
		physical=false,
		textures={"witchcraft_ice.png"},
		velocity = 1,
		rotate = 90,
		auto_rotate = true,
		damage = 2,
		collisionbox = {0, 0, 0, 0, 0, 0},
		on_step = function(self, obj, pos)		
			local remove = minetest.after(10, function() 
					self.object:remove()
			end)
			local pos = self.object:get_pos()
			local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:ice"
						and obj:get_luaentity().name ~= "__builtin:item"
					and obj:get_luaentity().name ~= "gauges:hp_bar" then
						obj:punch(self.object, 1.0, {
								full_punch_interval=1.0,
								damage_groups={fleshy=1},
							}, nil)
						self.object:remove()
						return
					end
				end
			end
			
			local velo = self.object:get_velocity()
			local hit = {
				{ p = {x=pos.x+1, y=pos.y, z=pos.z},
				  v = {x=math.abs(velo.x)*-1, y=velo.y, z=velo.z}}, -- x
				{ p = {x=pos.x-1, y=pos.y, z=pos.z},
				  v = {x=math.abs(velo.x), y=velo.y, z=velo.z}},
				{ p = {x=pos.x, y=pos.y+1, z=pos.z},
				  v = {x=velo.x, y=math.abs(velo.y)*-1, z=velo.z}}, -- y
				{ p = {x=pos.x, y=pos.y-1, z=pos.z},
				  v = {x=velo.x, y=math.abs(velo.y), z=velo.z}},
				{ p = {x=pos.x, y=pos.y, z=pos.z+1},
				  v = {x=velo.x, y=velo.y, z=math.abs(velo.z)*-1}}, -- z
				{ p = {x=pos.x, y=pos.y, z=pos.z-1},
				  v = {x=velo.x, y=velo.y, z=math.abs(velo.z)}}
			}

			for _,h in pairs(hit) do
				local n = minetest.get_node(h.p).name
				if n ~= "air" and n~= "witchcraft:ice" then
					if n == "default:water_source" or n =="default:river_water_source" then
						minetest.set_node(h.p, {name="default:ice"})
						h.v.y = 0
					end
					self.object:set_velocity(h.v)
					break
				end
			end

			minetest.add_particlespawner({
				amount = 10,
				time = 0.3,
				minpos = {x=pos.x-0.3, y=pos.y-0.3, z=pos.z-0.3},
				maxpos = {x=pos.x+0.3, y=pos.y+0.3, z=pos.z+0.3},
				minvel = {x=-0, y=-0, z=-0},
				maxvel = {x=0, y=0, z=0},
				minacc = {x=0,y=-0.5,z=0},
				maxacc = {x=0.5,y=0.5,z=0.5},
				minexptime = 0.1,
				maxexptime = 0.3,
				minsize = 0.2,
				maxsize = 0.5,
				collisiondetection = false,
				texture = "witchcraft_light_over.png"
			})
		end
})
