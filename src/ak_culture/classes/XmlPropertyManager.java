package ak_culture.classes;

import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Properties;


public class XmlPropertyManager {

	public static XmlPropertyManager instance = null;

	private static Hashtable<String, String> systemConfig = null;

	private static Hashtable<String, String> applicationMessage = null;

	private XmlPropertyManager() {
		systemConfig = new Hashtable<String, String>();
		applicationMessage = new Hashtable<String, String>();
		init();
	}

	private static synchronized XmlPropertyManager getInstance() {
		if (instance == null) {
			instance = new XmlPropertyManager();
		}
		return instance;
	}

	private void init() {
		setSystemXmlPropertyValue();
//		setApplicatonXmlPropertyValue();
	}

	private void setSystemXmlPropertyValue() {
		Properties properties = new Properties();

		try {
			InputStream xmlStream = getClass().getResourceAsStream(
					"/ak_web/properties/SystemConfig.xml");
			if (xmlStream == null) {
				// throw some error
			}
			properties.loadFromXML(xmlStream);
			Enumeration keys = properties.propertyNames();

			properties.list(System.out);

			while (keys.hasMoreElements()) {
				String key = (String) keys.nextElement();
				String value = properties.getProperty(key);
				systemConfig.put(key, value);
			}
		} catch (IOException exception) {
			exception.printStackTrace();
			// throw exception
		}
	}

	private void setApplicatonXmlPropertyValue() {
		Properties properties = new Properties();

		try {
			InputStream xmlStream = getClass().getResourceAsStream(
					"/com/ams/properties/ApplicationMessage.xml");
			if (xmlStream == null) {
				// throw some error
			}
			properties.loadFromXML(xmlStream);
			Enumeration keys = properties.propertyNames();

			properties.list(System.out);

			while (keys.hasMoreElements()) {
				String key = (String) keys.nextElement();
				String value = properties.getProperty(key);
				applicationMessage.put(key, value);
			}
		} catch (IOException exception) {
			exception.printStackTrace();
			// throw exception
		}
	}

	private String getSystemValue(String key) {
		return systemConfig.get(key);
	}

	private String getApplicationValue(String key) {
		return applicationMessage.get(key);
	}

	public static String getSystemProperty(String strKey) {
		
		XmlPropertyManager systemProper = XmlPropertyManager.getInstance();
		
		String strValue = systemProper.getSystemValue(strKey);
		if (strValue == null) {
			strValue = "입력하신 키값이 존재하지 않습니다.";
		} 
		return strValue;
	}

	public static String getMessageProperty(String strKey) {
		XmlPropertyManager applicationProper = XmlPropertyManager.getInstance();
		
		String strValue = applicationProper.getApplicationValue(strKey);
		if (strValue == null) {
			strValue = "입력하신 키값이 존재하지 않습니다.";
		} 
		return strValue;
	}

	public static String getMessageProperty(String strKey, String arg1) {
		XmlPropertyManager applicationProper = XmlPropertyManager.getInstance();
		String strValue = applicationProper.getApplicationValue(strKey);
		if (strValue == null) {
			strValue = "입력하신 키값이 존재하지 않습니다.";
		} else {
			strValue = StringUtil.replace("{1}", arg1, strValue);
		}
		return strValue;
	}

	public static String getMessageProperty(String strKey, String arg1,
			String arg2) {
		XmlPropertyManager applicationProper = XmlPropertyManager.getInstance();
		String strValue = applicationProper.getApplicationValue(strKey);
		if (strValue == null) {
			strValue = "입력하신 키값이 존재하지 않습니다.";
		} else {
			strValue = StringUtil.replace("{1}", arg1, strValue);
			strValue = StringUtil.replace("{2}", arg2, strValue);
		}
		return strValue;
	}

	public static String getMessageProperty(String strKey, String arg1,
			String arg2, String arg3) {
		XmlPropertyManager applicationProper = XmlPropertyManager.getInstance();
		String strValue = applicationProper.getApplicationValue(strKey);
		if (strValue == null) {
			strValue = "입력하신 키값이 존재하지 않습니다.";
		} else {
			strValue = StringUtil.replace("{1}", arg1, strValue);
			strValue = StringUtil.replace("{2}", arg2, strValue);
			strValue = StringUtil.replace("{3}", arg3, strValue);
		}
		return strValue;
	}

}
