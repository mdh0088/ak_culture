package ak_culture.classes;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

public class CommonDes { 

    public static String desCommon(String keyVaule, String type) {
        CommonDes des = new CommonDes();
        String strResult = "";
        
        try
        {
        	if("0".equals(type)) {
        		strResult = des.encrypt(keyVaule);
        	}
         	if("1".equals(type)) {
        		strResult = des.decrypt(keyVaule);
        	}       	
        	
        	return strResult;

        }
        catch (Exception e)
        {
            e.printStackTrace(System.out);
        }
        	return strResult;
        
        
    }

    public final static String SECURITYKEY = "AKRIS1234"; // �Ϻ�ȣȭ �ϴ� Ű���Դϴ�.

    private static SecretKey getKey(String strkey) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException{ 
        // �Է°��� bytes�� ��ȯ 
        byte[] desKeyData = strkey.getBytes(); 
        // ��ȣȭ Ű ���� 
        DESKeySpec desKeySpec = new DESKeySpec(desKeyData); 
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES"); 
        return keyFactory.generateSecret(desKeySpec); 
    } 
    // �ֹε�Ϲ�ȣ ó�� �������� ���� ��ȣȭ �ϰ� �ٽ� ��ȣ�� ���� Ű���� �ٲ�� �ȵǱ� ������ ������ Ű���� ���� �޼ҵ带 ����Ѵ�.  
    public static String encrypt(String data) throws Exception { 
        return encrypt(data, SECURITYKEY); 
    } 
    // �ֹε�Ϲ�ȣ ó�� �������� ���� ��ȣȭ �ϰ� �ٽ� ��ȣ�� ���� Ű���� �ٲ�� �ȵǱ� ������ ������ Ű���� ���� �޼ҵ带 ����Ѵ�.  
    public static String decrypt(String data) throws Exception { 
        return decrypt(data, SECURITYKEY); 
    } 
     
    public static String encrypt(String data, String strkey) throws Exception { 
        if (data == null || data.length() == 0) 
            return ""; 
        // ��ȣȭ�� ���� ����   
        Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding"); 
        cipher.init(Cipher.ENCRYPT_MODE, getKey(strkey)); 

        byte[] inputBytes1 = data.getBytes("UTF8"); 
        byte[] outputBytes1 = cipher.doFinal(inputBytes1); 

        sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder(); 
        return encoder.encode(outputBytes1); 
    } 
    public static String decrypt(String data, String strkey) throws Exception { 
        if (data == null || data.length() == 0) 
            return ""; 
        javax.crypto.Cipher cipher = javax.crypto.Cipher 
                .getInstance("DES/ECB/PKCS5Padding"); 
        cipher.init(javax.crypto.Cipher.DECRYPT_MODE, getKey(strkey)); 

        sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder(); 
        byte[] inputBytes1 = decoder.decodeBuffer(data); 
        byte[] outputBytes2 = cipher.doFinal(inputBytes1); 

        return new String(outputBytes2, "UTF8"); 
    } 

} 

