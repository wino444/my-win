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

-- ✅ ตารางแมพที่รองรับพร้อม URL
local validMapScripts = {
    [4503309821] = "https://raw.githubusercontent.com/wino444/HexaSolstice_wino444/refs/heads/main/main.lua",
    [6584793416] = "https://raw.githubusercontent.com/wino444/2/refs/heads/main/%E0%B9%81%E0%B8%A1%E0%B8%9E%20%E0%B8%88%E0%B8%B3%E0%B8%A5%E0%B8%AD%E0%B8%87%E0%B8%9E%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B8%87%E0%B8%B2%E0%B8%99%E0%B9%84%E0%B8%9F%E0%B8%9F%E0%B9%89%E0%B9%88%E0%B8%99%E0%B8%B4%E0%B8%A7%E0%B9%80%E0%B8%84%E0%B8%A5%E0%B8%B5%E0%B8%A2%E0%B8%A3%E0%B9%8C",
    -- เพิ่มแมพอื่น ๆ ตามต้องการ
}

-- ✅ ฟังก์ชันโหลดและรันสคริปต์ตาม URL
local function loadAndRun(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        local func, err = loadstring(result)
        if func then
            func()
        else
            warn("[โหลด] ผิดพลาด: " .. err)
        end
    else
        warn("[HttpGet] ผิดพลาด: " .. result)
    end
end

-- ✅ ตรวจสอบและรัน
local placeId = game.PlaceId
if validMapScripts[placeId] then
    loadAndRun(validMapScripts[placeId])
else
    warn("[ระบบ] ยังไม่รองรับแมพนี้: " .. placeId)
end
