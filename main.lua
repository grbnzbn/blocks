pieceStructures = {
	{ -- I
		{
			{' ', ' ', ' ', ' '},
			{'i', 'i', 'i', 'i'},
			{' ', ' ', ' ', ' '},
			{' ', ' ', ' ', ' '},
		},
		{
			{' ', 'i', ' ', ' '},
			{' ', 'i', ' ', ' '},
			{' ', 'i', ' ', ' '},
			{' ', 'i', ' ', ' '},
		},
	},
	{ -- 0
		{
			{' ',' ',' ',' '},
			{' ','o','o',' '},
			{' ','o','o',' '},
			{' ',' ',' ',' '},
		},
	},
	{ -- J
		{
			{' ',' ',' ',' '},
			{'j','j','j',' '},
			{' ',' ','j',' '},
			{' ',' ',' ',' '},
		},
		{
			{' ','j',' ',' '},
			{' ','j',' ',' '},
			{'j','j',' ',' '},
			{' ',' ',' ',' '},
		},
		{
			{'j',' ',' ',' '},
			{'j','j','j',' '},
			{' ',' ',' ',' '},
			{' ',' ',' ',' '},
		},
		{
			{' ','j','j',' '},
			{' ','j',' ',' '},
			{' ','j',' ',' '},
			{' ',' ',' ',' '},
		},
	},
	{ -- L
		{
			{' ',' ',' ',' '},
			{'l','l','l',' '},
			{'l',' ',' ',' '},
			{' ',' ',' ',' '},
		},
		{
			{' ','l',' ',' '},
			{' ','l',' ',' '},
			{' ','l','l',' '},
			{' ',' ',' ',' '},
		},
		{
			{' ',' ','l',' '},
			{'l','l','l',' '},
			{' ',' ',' ',' '},
			{' ',' ',' ',' '},
		},
		{
			{'l','l',' ',' '},
			{' ','l',' ',' '},
			{' ','l',' ',' '},
			{' ',' ',' ',' '},
		},
	},
	{ -- T
		{
			{' ',' ',' ',' '},
			{'t','t','t',' '},
			{' ','t',' ',' '},
			{' ',' ',' ',' '},
		},
		{
			{' ','t',' ',' '},
			{' ','t','t',' '},
			{' ','t',' ',' '},
			{' ',' ',' ',' '},
		},
		{
			{' ','t',' ',' '},
			{'t','t','t',' '},
			{' ',' ',' ',' '},
			{' ',' ',' ',' '},
		},
		{
			{' ','t',' ',' '},
			{'t','t',' ',' '},
			{' ','t',' ',' '},
			{' ',' ',' ',' '},
		},	
	},
	{ -- S
		{
			{' ',' ',' ',' '},
			{' ','s','s',' '},
			{'s','s',' ',' '},
			{' ',' ',' ',' '},
		},
		{
			{'s',' ',' ',' '},
			{'s','s',' ',' '},
			{' ','s',' ',' '},
			{' ',' ',' ',' '},
		},
	},
	{ -- Z
		{
			{' ',' ',' ',' '},
			{'z','z',' ',' '},
			{' ','z','z',' '},
			{' ',' ',' ',' '},
		},
		{
			{' ','z',' ',' '},
			{'z','z',' ',' '},
			{'z',' ',' ',' '},
			{' ',' ',' ',' '},
		},
	},
}

-- One-time setup of game
function love.load()
	love.window.setTitle("Blocks")
	love.window.setMode(200, 400)
	love.graphics.setBackgroundColor(255, 255, 255) -- Set background color: white

	gridXCount = 10
	gridYCount = 20

	inert = {}
	for y = 1, gridYCount do
		inert[y] = {}
		for x = 1, gridXCount do
			inert[y][x] = ' ' -- ' ' represents an empty cell
		end
	end

	-- TEMPORARY TO SHOW COLORS
    --inert[18][1] = 'i'
    --inert[17][2] = 'j'
    --inert[16][3] = 'l'
    --inert[15][4] = 'o'
    --inert[14][5] = 's'
    --inert[13][6] = 't'
    --inert[12][7] = 'z'

    pieceType = 1
    pieceRotation = 1

    -- Position of the piece in the playing area
    pieceX = 3
    pieceY = 0

end -- End function love.load()

-- Manage game state frame-to-frame
function love.update(dt)

end

-- Renders game state onto screen
function love.draw()

	-- Drawing the grid of blocks
	for y = 1, gridYCount do	 -- Height of grid
		for x = 1, gridXCount do -- Width of grid
			drawBlock(inert[y][x], x, y)
		end
	end

	for y = 1, 4 do
		for x = 1, 4 do
			local block = pieceStructures[pieceType][pieceRotation][y][x]
			if block ~= ' ' then
				drawBlock(block, x + pieceX, y + pieceY)
			end
		end
	end

end -- End function love.draw()

function love.keypressed(key)

	if key == 'x' then -- Rotate right (clockwise)
		pieceRotation = pieceRotation + 1
		if pieceRotation > #pieceStructures[pieceType] then
			pieceRotation = 1
		end
	elseif key == 'z' then -- Rotate left (counter clockwise)
		pieceRotation = pieceRotation - 1
		if pieceRotation < 1 then
			pieceRotation = #pieceStructures[pieceType]
		end
	elseif key == 'down' then --end
		pieceType = pieceType + 1
		if pieceType > #pieceStructures then
			pieceType = 1
		end
		pieceRotation = 1
	elseif key == 'up' then
		pieceType = pieceType - 1
		if pieceType < 1 then
			pieceType = #pieceStructures
		end
		pieceRotation = 1
	end

	-- TEMPORARY TO TEST CYCLE PIECE TYPES

end -- End function love.keypressed(key)

function drawBlock(block, x, y)
	local colors = {
		[' '] = {222, 222, 222},
		i = {120, 195, 239},
		j = {236, 231, 108},
		l = {124, 218, 193},
		o = {234, 177, 121},
		s = {211, 136, 236},
		t = {248, 147, 196},
		z = {169, 221, 118},
	}
	local color = colors[block]
	love.graphics.setColor(color)

	local blockSize = 20
	local blockDrawSize = blockSize - 1

	love.graphics.rectangle(
		'fill',
		(x - 1) * blockSize, -- X position
		(y - 1) * blockSize, -- Y position
		blockDrawSize,		 -- Block width
		blockDrawSize		 -- Block height
	)
end