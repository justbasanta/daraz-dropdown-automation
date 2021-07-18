require 'selenium-webdriver'
Selenium::WebDriver::Chrome.driver_path="/home/shishir/Documents/chrome-driver/chromedriver"
caps = Selenium::WebDriver::Remote::Capabilities.chrome("goog:chromeOptions" => {"args" => ['disable-notifications']})

driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps

$url = "https://daraz.com.np"
$expected_page_text = "Keyboards"
$wait = Selenium::WebDriver::Wait.new(timeout: 30, interval: 5, message: 'Timed out after 30 sec')

def find_keyboard(driver)
    electronic_acc_ele = driver.find_element(:id, 'Level_1_Category_No2')
    driver.action.move_to(electronic_acc_ele).perform
    $wait.until {driver.find_element(:xpath,'//*[@id="J_8018372580"]/div/ul/ul[2]/li[6]/a/span').displayed?}

    computer_acc_subele = driver.find_element(:xpath,'//*[@id="J_8018372580"]/div/ul/ul[2]/li[6]/a/span')
        
    driver.action.move_to(computer_acc_subele).perform

    $wait.until {driver.find_element(:xpath, '//*[@id="J_8018372580"]/div/ul/ul[2]/li[6]/ul/li[2]/a/span').displayed?}
    keyboards_subele = driver.find_element(:xpath, '//*[@id="J_8018372580"]/div/ul/ul[2]/li[6]/ul/li[2]/a/span')
    driver.action.move_to(keyboards_subele).perform
    keyboards_subele.click()
end

def confirm_keyboards_page(driver)
    check_page = driver.find_element(:class, "c2BJaq").text
    check_page == $expected_page_text ? (p "Test PASS") : (p "Test FAIL!!")
end


begin
    driver.navigate.to $url
    logo_ele= driver.find_element(:xpath, "//*[@id='topActionHeader']//div[@class='lzd-logo-content']/a/img")
    logo_alt_text = logo_ele.attribute("alt")
    logo_alt_text == "Sell on Daraz" ? (p "I'm in the daraz website") : (raise "Not in Daraz website, check your url !!")

    find_keyboard(driver)
    confirm_keyboards_page(driver)

ensure
     driver.quit
end