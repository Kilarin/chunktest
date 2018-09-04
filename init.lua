--chunktest


--grab content IDs -- You need these to efficiently access and set node data.  get_node() works, but is far slower
local c_brick = minetest.get_content_id("default:brick")



function chunktest(minp, maxp, seed)
  --ok, now we know we are in a chunk that has beanstalk in it, so we need to do the work
  --required to generate the beanstalk

  --easy reference to commonly used values
  local t1 = os.clock()
  local x1 = maxp.x
  local y1 = maxp.y
  local ymax=maxp.y
  local z1 = maxp.z
  local x0 = minp.x
  local y0 = minp.y
  local ymin=minp.y
  local z0 = minp.z

  --This actually initializes the LVM
  local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
  local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
  local data = vm:get_data()

 --outline chunk for debugging
  local x
  local z
  local vi
  for x=x0, x1 do
    y=y0
    z=z0
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
    z=z1
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
    y=y1
    z=z0
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
    z=z1
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
  end --for x
  for z=z0, z1 do
    y=y0
    x=x0
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
    x=x1
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
    y=y1
    x=x0
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
    x=x1
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
  end --for z
  for y=y0, y1 do
    z=z0
    x=x0
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
    x=x1
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
    z=z1
    x=x0
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
    x=x1
    vi = area:index(x, y, z) -- This accesses the node at a given position
    data[vi]=c_brick
  end --for y
    -- Wrap things up and write back to map
    --send data back to voxelmanip
    --minetest.log(checkcontent(8573,47,8136,area,data," before save chunk "..x0..","..y0..","..z0))
    vm:set_data(data)
    --calc lighting
    vm:set_lighting({day=0, night=0})
    vm:calc_lighting()
    --write it to world
    vm:write_to_map(data)
    --minetest.log(">>>saved")
    --minetest.log(checkcontent(8573,47,8136,area,data," after save chunk "..x0..","..y0..","..z0))

  local chugent = math.ceil((os.clock() - t1) * 1000) --grab how long it took
  minetest.log("chunktest END chunk="..x0..","..y0..","..z0.." - "..x1..","..y1..","..z1.."  "..chugent.." ms") --tell people how long
end -- chunktest


minetest.register_on_generated(chunktest)



