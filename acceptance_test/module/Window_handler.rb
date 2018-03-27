require_relative '../Helpers_pages/helper_page'


module WindowHandler

  def switch_to_alert_accept
    @driver.switch_to.alert.accept
  end

  def switchWindowToWindowHandleLast()
    @driver.switch_to.window @driver.window_handles.last
  end

  def switchWindowToWindowHandleFirst()
    @driver.switch_to.window @driver.window_handles.first
  end

  def getTotalWindowsOpen()
    return @driver.window_handles.length
  end

  def getWindowSize()
    return @driver.manage.window.size
  end

  def resizeWindowTo(width, height)
    @driver.manage.window.resize_to(width, height)
    sleep 0.5
  end

  def resizeWindowToPhone()
    resizeWindowTo(320, 480)
  end

  def resizeWindowToDefault()
    resizeWindowTo(1260, 727)
    sleep 0.5
  end

  def maximizeWindow
    @driver.manage.window.maximize
  end

  def closeBrowser()
    @driver.close()
  end

  def deleteAllCookies()
    @driver.manage.delete_all_cookies
  end

  def clickBackButtonOnBrowser()
    @driver.navigate.back()
  end

  def refreshBrowser()
    @driver.navigate().refresh()
  end



end