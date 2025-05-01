-- ✅ ฟังก์ชันแสดง log ใน console แบบกำหนดระดับ
local function log(level, message)
    local prefix = "[ระบบ] "

    if level == "info" then
        print(prefix .. message)
    elseif level == "warn" then
        print(prefix .. "[คำเตือน] " .. message)
    elseif level == "error" then
        print(prefix .. "[ผิดพลาด] " .. message)
    else
        print(prefix .. "[ทั่วไป] " .. message)
    end
end

-- ✅ รายชื่อแมพและ URL ที่ตรงกัน
local mapIDs = {
    4503309821, -- เมืองไทย2
    6584793416, -- จำลองไฟฟ้านิวเคลียร์
    345678,
    901234,
    567890,
    234567,
    890123,
    456789,
    123890,
    567123
}

local scriptURLs = {
    "https://raw.githubusercontent.com/wino444/HexaSolstice_wino444/refs/heads/main/main.lua",
    "https://raw.githubusercontent.com/wino444/2/refs/heads/main/%E0%B9%81%E0%B8%A1%E0%B8%9E%20%E0%B8%88%E0%B8%B3%E0%B8%A5%E0%B8%AD%E0%B8%87%E0%B9%84%E0%B8%9F%E0%B8%9F%E0%B9%89%E0%B8%B2%E0%B8%99%E0%B8%B4%E0%B8%A7%E0%B9%80%E0%B8%84%E0%B8%A5%E0%B8%B5%E0%B8%A2%E0%B8%A3%E0%B9%8C",
    "https://example.com/script3.lua",
    "https://example.com/script4.lua",
    "https://example.com/script5.lua",
    "https://example.com/script6.lua",
    "https://example.com/script7.lua",
    "https://example.com/script8.lua",
    "https://example.com/script9.lua",
    "https://example.com/script10.lua"
}

-- ✅ ตรวจสอบแมพและโหลดสคริปต์
local function checkMapAndRunScript()
    local placeId = game.PlaceId

    if #mapIDs ~= #scriptURLs then
        log("error", "จำนวน mapIDs และ scriptURLs ไม่ตรงกัน")
        return
    end

    local found = false

    for index, id in ipairs(mapIDs) do
        if placeId == id then
            local url = scriptURLs[index]

            if not url:match("^https?://") then
                log("error", "URL ไม่ถูกต้อง: " .. tostring(url))
                return
            end

            log("info", "พบแมพที่รองรับ กำลังโหลดสคริปต์...")

            local success, result = pcall(function()
                return game:HttpGet(url)
            end)

            if success then
                local func, err = loadstring(result)
                if func then
                    local ok, runErr = pcall(func)
                    if not ok then
                        log("error", "สคริปต์ทำงานล้มเหลว: " .. tostring(runErr))
                    end
                else
                    log("error", "โหลดสคริปต์ไม่สำเร็จ: " .. tostring(err))
                end
            else
                log("error", "ไม่สามารถโหลดจาก URL ได้: " .. tostring(url))
            end

            found = true
            break
        end
    end

    if not found then
        log("warn", "ยังไม่รองรับแมพนี้: " .. placeId)
    end
end

checkMapAndRunScript()
