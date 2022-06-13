package ak_culture.classes;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.*;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;

public class StringUtil {
	
	static BitSet dontNeedEncoding;
	static final int caseDiff = ('a' - 'A');	

    /**
     * "<",">","\r"을 html 코드로 변환 한다.
     * @param st_content - 변경할 문자열
     * @return 변경된 문자열
     */
    public static String convertTxt2Tag(String st_content) {
        st_content = change(st_content, "<", "&lt;");
        st_content = change(st_content, ">", "&gt;");
        st_content = change(st_content, "\"", "&quot;");
        st_content = change(st_content, "'", "''");
        st_content = change(st_content, "\r", "<br/>");
        return st_content;
    }

    /**
     * "<",">","\r"을 html 코드로 변환 한다.
     * @param st_content - 변경할 문자열
     * @return 변경된 문자열
     */
    public static String convertTxt2TagArea(String st_content) {
        st_content = change(st_content, "<", "&lt;");
        st_content = change(st_content, ">", "&gt;");
        st_content = change(st_content, "\"", "&quot;");
        st_content = change(st_content, "'", "''");
        return st_content;
    }

    /**
     * 스트링내의 임의의 문자열을 새로운 문자열로 대치하는 메소드
     * @param source - 스트링
     * @param before - 바꾸고자하는 문자열
     * @param after - 바뀌는 문자열
     * @return 변경된 문자열
     */
    public static String change(String source, String before, String after) {
        int i = 0;
        int j = 0;
        StringBuffer sb = new StringBuffer();
        while ((j = source.indexOf(before, i)) >= 0) {
            sb.append(source.substring(i, j));
            sb.append(after);
            i = j + before.length();
        }
        sb.append(source.substring(i));
        return sb.toString();
    }

    /**
     * 캐리지 리턴값을 체크하여 br tag로 컨버젼한다.
     * @param comment - 캐리지 리턴값을 체크할 문자열
     * @return 캐리지 리턴값이 변환된 문자열(br tag로 변환)
     */
    public static String convertHtmlBr(String comment) {
        int length = comment.length();
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < length; ++i) {
            String comp = comment.substring(i, i + 1);
            if ("\r".compareTo(comp) == 0) {
                comp = comment.substring(++i, i + 1);
                if ("\n".compareTo(comp) == 0) {
                    buffer.append("<br/>\r");
                }
                else {
                    buffer.append("\r");
                }
            }
            if ("\n".compareTo(comp) == 0) {
                if (i < length - 1) {
                    comp = comment.substring(++i, i + 1);
                    buffer.append("<br/>\r");
                }
            }
            buffer.append(comp);
        }
        return buffer.toString();
    }

    /**
     * null값을 체크해서 지정된 문자열로 대체.
     * @param param - 변환할 문자열
     * @param newParam - 변환된 문자열
     * @return 널 대체 문자열
     */
    public static String nvl(String param, String newParam) {
        if (param == null || param.equals("") || param.length() == 0 || param.equals("null")) {
            String reParam = newParam;
            return reParam;
        }
        else {
            return param;
        }
    }
    
    /**
     * BigDecimal의 null값을 체크해서 0으로 대체.
     * @param param - 변환할 숫자값
     * @return 널 대체 문자열
     */    
    public static BigDecimal nvl(BigDecimal param) {
    	if (param == null) {
    		return new BigDecimal(0);
    	}
    	return param;
    }

    /**
     * null값을 체크해서 null이면 ""를 반환.
     * @param arg - 검사할 문자열
     * @return 검사 결과 문자열
     */
    public static String nvl(String arg) {
        if (arg == null || arg.equals("null")) {
            return "";
        }
        return arg;
    }    

    /**
     * 지정한 길이만큼의 문자열만 추출해서 보여주고 끝부분은 대체 문자열로 대체
     * @param str - 대체할 문자열
     * @param len - 보여줄 문자열의 길이
     * @return 변경된 문자열
     */
    public static String subStringPoint(String str, int len, String newStr) {
    	if (str == null || newStr == null) {
    		return "";
    	}
        if (str.length() <= len) {
            return str;
        }
        str = str.substring(0, len);
        str = str + newStr;
        return str;
    }

    /**
     * 지정된 Token으로 지정한 위치의 문자열을 리턴
     * @param str - 원시문자열
     * @param delim - 분리될Token
     * @param ipos - 분리된 문자열 위치
     * @return 분리된 문자열
     */
    public static String toKen(String str, String delim, int ipos) {
        int i;
        int ilen = str.length();
        int idel = delim.length();
        int ista = 0, iend = 0, isee = 0;
        for (i = 0; i < ilen; i++) {
            String ss2 = str.substring(i, idel + i);
            if (ss2.equals(delim)) {
                if (isee == 0)
                    ista = 0;
                else
                    ista = iend + 1;
                iend = i;
                if (ipos == isee) {
                    return str.substring(ista, iend);
                }
                isee++;
            }
        }
        if (isee == 0) {
            return str;
        }
        if (i == ilen) {
            ista = iend + 1;
            iend = ilen;
            return str.substring(ista, iend);
        }
        return "";
    }

    /**
     * 체크박스 선택시 반환된 문자열 배열을 구분자를 포함하여 하나의 단일 문자로 변환 후 반환<br>
	 * 예) String[] array = {"aaa","bbb","ccc"}<br>
     * String result = combineString(array,",");<br>
     * return "aaa,bbb,ccc"
     * 
     * @param   array - 체크박스에 선택된 문자열 배열
     * @param   gubun - 구분자 문자
     * @return  해당 문자열을 조합한 새로운 문자열
     */
    public static String combineString(String[] array, String gubun) {
        String result = "";
        if (array != null) {
            for (int k = 0; k < array.length; k++) {
                result += array[k];
                if (array.length != k + 1) {
                    result += gubun;
                }
            }
        }
        return result;
    }

    /**
     * 넘어온 문자열을 해당 구분자로 잘라 배열로 반환한다<BR>
	 * 예) String[] result = divideString("A01,B01,C01", ",");<br>
	 * return "A01","B01","C01"
	 * 
     * @param    str - 조합된 문자열
     * @param    gubun - 구분자 문자
     * @return   분리된 문자열 배열
     */
    public static String[] divideString(String str, String gubun) {
        if (str == null) return null;
        String[] result = null;
        StringTokenizer st = new StringTokenizer(str, gubun);
        result = new String[st.countTokens()];
        for (int i = 0; st.hasMoreTokens(); i++)
            result[i] = st.nextToken();
        return result;
    }

    /**
     * 문자열 배열을 쿼리의 in조건 형태의 문자로 변환 후 반환<br>
	 * 예)<br> String[] array = {"aaa","bbb","ccc"}<br>
     * String result = getInQueryString(array);<br>
     * return 'aaa','bbb','ccc'
     * 
     * @param   array - 문자열 배열
     * @return  해당 문자열을 조합한 새로운 문자열
     */
    public static String getInQueryString(String[] array) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < array.length; i++) {
            sb.append("'").append(array[i]).append("'").append(",");
        }
        sb.delete(sb.length() - 1, sb.length());
        return sb.toString();
    }

	/**
	 * urlencode와 비슷하나 공백을 +로 바꾸지 않고 공백도 hexa code값으로 바꾼다<br>
	 * 예) %2Fjsp%2Ftest.jsp%3Fname%3D%C1%A4%BF%B5_%BC%B1. 형태를 반환<br>
	 * 위에서 공백에 해당하는 부분의 문자가  이다 
	 * 
	 * @param s - 변환할 문자열
	 * @return hexa code값으로 바뀐 문자열
	 */
	public static String encode(String s) {
		if(s == null || s.equals("")) return "";
		int maxBytesPerChar = 10;
		ByteArrayOutputStream out = new ByteArrayOutputStream(s.length());
		ByteArrayOutputStream buf = new ByteArrayOutputStream(maxBytesPerChar);
		OutputStreamWriter writer = new OutputStreamWriter(buf);
	    for (int i = 0; i < s.length(); i++) {
			int c = (int)s.charAt(i);
			if (dontNeedEncoding.get(c)) {
				if (c == ' ') {
					c = (char)17;
				}
				out.write(c);
			} else {
				// convert to external encoding before hex conversion
				try {
					writer.write(c);
					writer.flush();
				} catch(IOException e) {
					buf.reset();
					continue;
				}
				byte[] ba = buf.toByteArray();
				for (int j = 0; j < ba.length; j++) {
					out.write('%');
					char ch = Character.forDigit((ba[j] >> 4) & 0xF, 16);
					// converting to use uppercase letter as part of
					// the hex value if ch is a letter.
					if (Character.isLetter(ch)) {
						ch -= caseDiff;
					}
					out.write(ch);
					ch = Character.forDigit(ba[j] & 0xF, 16);
					if (Character.isLetter(ch)) {
						ch -= caseDiff;
					}
					out.write(ch);
				} // end for
				buf.reset();
			} // end if else
		} // end for
		return out.toString();
	}

	/**
	 * urldecode와 비슷하나 본 class(StringUtil.class)의 encode 함수로 변환된 문자열을 본래 문자로 변환한다
	 * @param s - 변환할 문자열
	 * @return 변경된 문자열
	 */
	public static String decode(String s) {
		if(s==null||s.equals("")) return "";
		StringBuffer sb = new StringBuffer();
		for(int i=0; i<s.length(); i++) {
			char c = s.charAt(i);
			switch (c) {
				case (char)17:	// 0x11(공백)
					sb.append(' ');
					break;
				case '%':
					if(s.length()==i+1) {
						sb.append(c);
						break;
					}
					if(s.length()==i+2) {
						sb.append(s.substring(i,i+2));
						i++;
						break;
					}
					try {
						sb.append((char)Integer.parseInt(s.substring(i+1,i+3),16));
					}catch (NumberFormatException e) {
						//throw new IllegalArgumentException();
						//sb.append(c);
						sb.append(s.substring(i,i+3));
					}
					i += 2;
					break;
				default:
					sb.append(c);
					break;
			}
		}
		// Undo conversion to external encoding
		String result = sb.toString();
		return toKo(result);
	}

	/**
	 * 8859_1을 KSC5601(EUC_KR)로 변환
	 * @param ascii - 8859_1로 조합된 문자열
	 * @return EUC_KR로 조합된 문자열
	 */
	public static String toKo(String ascii){
		if (ascii == null)
			return "";
		try{
			ascii = new String ( ascii.getBytes ("8859_1"), "EUC_KR" );
		}catch(Exception e){
			return "";
		}
		return ascii;
	}

	/**
	 * KSC5601(EUC_KR)을 8859_1로 변환
	 * 
	 * @param euc_kr - EUC_KR로 조합된 문자열
	 * @return 8859_1로 조합된 문자열
	 */
	public static String toEn(String euc_kr){
		if (euc_kr == null)
			return "";
		try{
			euc_kr = new String ( euc_kr.getBytes ("EUC_KR"), "8859_1" );
		}catch(Exception e){
			return "";
		}
		return euc_kr;
	}	

	/**
	 * 해당 문자가 null인지만 검사하여 맞으면 true 아니면 false반환
	 * 
	 * @param str - 검사할 문자열
	 * @return 검사 결과 여부
	 */
	public static boolean isNull(String str){
		return (str == null) ? true : false;
	}

	/**
	 * 해당 문자가 null이거나 공백이면 true 아니면 false반환
	 * 
	 * @param str - 검사할 문자열
	 * @return 검사 결과 여부
	 */
	public static boolean isEmptyString(String str){
		return (str == null || "".equals(str)) ? true : false;
	}

	/**
	 * 해당 문자가 null이면 공백("") 문자를 반환한다
	 * 
	 * @param str - 검사할 문자열
	 * @return 검사 결과 문자열
	 */
	public static String toBlank(String str){
		return (isEmptyString(str)) ? "" : str;
	}

	/**
	 * 해당 문자가 null이거나 공백이면 0을 그렇지 않으면 해당 문자의 int값을 반환한다
	 * @param str - 검사할 문자열
	 * @return 검사 결과 숫자
	 */
	public static int toInt(String str){
		return (isEmptyString(str)) ? 0 : Integer.parseInt(str);
	}

	/**
	 * 해당 문자가 null이거나 공백이면 0을 그렇지 않으면 해당 문자의 char값을 반환한다
	 * 
	 * @param str - 검사할 문자열
	 * @return 검사 결과 문자
	 */
	public static char toChar(String str){
		return (isEmptyString(str) || str.length() > 1) ? 0 : str.charAt(0);
	}

	/**
	 * 해당 문자가 true이면 true값을 그렇지 않으면 false값을 반환
	 * 
	 * @param str - 검사할 문자열
	 * @return 검사 결과 여부
	 */
	public static boolean toBoolean(String str){
		return (isEmptyString(str)) ? false : ("true".equals(str)) ? true : false;
	}

	/**
	 * 해당 문자가 null이거나 공백이면 0값을 그렇지 않으면 해당 문자열 BigDecimal값을 반환
	 * 
	 * @param str - 검사할 문자열
	 * @return 검사 결과 숫자
	 */
	public static BigDecimal toBigDecimal(String str){
		return (isEmptyString(str)) ? new BigDecimal(0) : new BigDecimal(str);
	}
	
	/**
	 * 해당 문자가 null이거나 공백이면 대체 문자열을 반환한다
	 * 
	 * @param search - 검사할 문자열
	 * @param replace - 대체할 문자열
	 * @return 검사 결과 문자열
	 */
	public static String toBlank(String search, String replace){
		return (isEmptyString(search)) ? replace : search;
	}

	/**
	 * 해당 문자가 null이거나 공백이면 대체할 문자열 숫자를 반환한다
	 * 
	 * @param search - 검사할 문자열
	 * @param replace - 대체할 문자열 숫자
	 * @return 검사 결과 숫자
	 */
	public static int toInt(String search, String replace){
		return (isEmptyString(search)) ? Integer.parseInt(replace) : Integer.parseInt(search);
	}

	/**
	 * 해당 문자가 null이거나 공백이면 해당 문자의 char값을 반환한다
	 * 
	 * @param search - 검사할 문자열
	 * @param replace - 대체할 문자
	 * @return 검사 결과 문자
	 */
	public static char toChar(String search, char replace){
		return (isEmptyString(search) || search.length() > 1) ? replace : search.charAt(0);
	}

	/**
	 * 해당 문자가 null이거나 공백이면 해당 BigDecimal값을 반환한다.
	 * 
	 * @param search - 검사할 문자열
	 * @param replace - 대체할 숫자
	 * @return 검사 결과 숫자
	 */
	public static BigDecimal toBigDecimal(String search, BigDecimal replace){
		return (isEmptyString(search)) ? replace : new BigDecimal(search);
	}	
	
	/**
	 * 해당 문자가 null이거나 공백이면 해당 문자열 BigDecimal값을 반환한다.
	 * 
	 * @param search - 검사할 문자열
	 * @param replace - 대체할 문자열 숫자
	 * @return 검사 결과 숫자
	 */
	public static BigDecimal toBigDecimal(String search, String replace){
		return (isEmptyString(search)) ? new BigDecimal(replace) : new BigDecimal(search);
	}
	
	/**
	 * 문자열이 길 경우 인자로 넘겨받은 사이즈만큼 보여주고 ...문자로 대체
	 * 
	 * @param str - 변경할 문자열
	 * @param size - 문자열 사이즈
	 * @return 변경된 문자열
	 */
	public static String getCutString(String str, int size) {
		if(str == null) return "";
		str = str.trim();
		if(str.length() <= size) return str;
		String res = str.substring(0, size) + " ...";
		return res;
	}

	/**
	 * text의 특수문자(<,>,"" 등)를 html 코드형식(&lt,&gt,&quot 등)으로 변환
	 * 
	 * @param content - text 문자열
	 * @return html로 변경된 문자열
	 */
	public static String toHtml(String content) {
		if (content == null) return "";
		String html = content;

		StringBuffer buffer = new StringBuffer();
		String temp = new String();
		for (int i=0; i<html.length(); ++i){
			temp = html.substring(i, i+1);
			if( "<".equals(temp) )
				buffer.append( "&lt;" );
			else if( ">".equals(temp) )
				buffer.append( "&gt;" );
			else if( "@".equals(temp) )
				buffer.append( "&copy;" );
			else if( "&".equals(temp) )
				buffer.append( "&amp;" );
			else if( "\"".equals(temp) )
				buffer.append( "&quot;" );
			else
				buffer.append( temp );
		}
		html = buffer.toString();

		return html;
	}

	/**
	 * text의 '\n' 값을 html형식에 맞추어 <br>로 변환시켜줍니다.
	 * @param content - 변환할 text 문자열
	 * @return html로 변환된 문자열
	 */
	public static String toBRtag(String content) {
		if (content == null) return "";
		String html = content;

/*
		// 방법1
		StringBuffer buffer = new StringBuffer();
		String temp = new String();
		for (int i=0; i<html.length(); ++i){
			temp = html.substring(i, i+1);
			if( "\n".equals(temp) )
				buffer.append( "<br>" );
			else
				buffer.append( temp );
		}
		html = buffer.toString();
*/
		// 방법2
		int index=0;
		while((index=html.indexOf('\n'))>0) {
			html = html.substring(0,index) + "<br/>" + html.substring(index+1);
		}
		return html;
	}

	/**
	 * 내용 등록시 내용이 길 경우<br>
	 * 내용을 인자로 받은 크기만큼 잘라서 벡터 배열에 저장 후 반환한다
	 * 
	 * @param content - 자를 문자열
	 * @param bufSize - 버퍼 사이즈
	 * @return 분리된 문자열 Vector 반환
	 */
	public static Vector splitContents(String content, int bufSize){
		Vector contents = new Vector();
		if(isEmptyString(content)){
			contents.addElement("");
			return contents;
		}

		int LAST_ASCII_CODE = 255;
		int cntlen = content.getBytes().length;
		int strlen = 0;
		int bylen = 0;
		char c = 0;

		while(cntlen > 0){
			if(cntlen > bufSize){
				while(bylen < bufSize){
					c = content.charAt(strlen);
					bylen++;
					strlen++;
					if( c > LAST_ASCII_CODE ){	// 한글이면
						bylen++;
					}
				}
			}else{
				strlen = content.length();
				bylen = content.getBytes().length;
			}
			cntlen -= bylen;
			contents.addElement(content.substring(0,strlen));
			content = content.substring(strlen);
			strlen = 0;
			bylen = 0;
		}
		return contents;
	}


	/**
	 * 인자로 받은 old문자열을 new문자열로 대체한다<br>
	 * 대소문자를 구분하여 정확하게 일치하는 문자열만 대체한다<br>
	 * 예) replace("hello", "welcome", "Hello hello my house")<br>
	 * returns "Hello welcome my house"
	 * 
	 * @param oldStr - 대체될 문자열
	 * @param newStr - 대체할 문자열
	 * @param src - 원본 문자열
	 * @return  해당 문자열로 대체한 후의 새로운 문자열
	 */
	public static String replace(String oldStr, String newStr, String src){
		if(isEmptyString(oldStr) || isNull(newStr) || isEmptyString(src) )
			return "";
		String des = new String();
		int oldLen = oldStr.length();
		int start = 0;
		int end = 0;
		while( (end = src.indexOf(oldStr,start)) > -1){
			des = des.concat(src.substring(start, end));
			des = des.concat(newStr);
			start = end+oldLen;
		}
		des = des.concat(src.substring(start));
		return des;
	}


	/**
	 * 체크박스 선택시 반환된 문자열 배열을 하나의 단일 문자로 변환 후 반환<br>
	 * 예) String[] array = {"aaa","bbb","ccc"}<BR>
	 *     String result = combineString(array);<br>
	 *     return "aaabbbccc"
	 *     
	 * @param  array - 체크박스에 선택된 문자열 배열
	 * @return 해당 문자열을 조합한 새로운 문자열
	 */

	public static String combineString(String[] array){
		String result = "";
		if( array != null ){
			for(int i=0; i<array.length; i++){
				result += array[i];
			}
		}
		return result;
	}


	/**
	 * 넘어온 문자열을 term만큼씩 잘라 배열로 반환한다<br>
	 * 예) String[] result = divideString("A01B01C01", 3);<br>
	 *     return "A01","B01","C01"
	 * @param str - 문자열 조합
	 * @param term - 자를 길이
	 * @return 분리된 문자열 배열
	 */
	public static String[] divideString(String str, int term){

		if( str == null ) return null;

		int array_count = str.length()/term;
		String[] result = new String[array_count];
		int start = 0;
		int end   = 0;
		for(int i=0; i<array_count; i++){
			start = i*term;
			end   = (i+1)*term;
			result[i] = str.substring(start,end);
		}
		return result;
	}
	
	/**
	 * 해당 문자열이 날짜 포멧에 맞는지 여부
	 * @param date - 날짜 문자열
	 * @return 검사 결과 유무
	 */
	public static boolean isDate(String date) {
		return isDate(date, 8);
	}
	
	/**
	 * 해당 문자열이 날짜 포멧에 맞는지 여부
	 * @param date - 날짜 문자열
	 * @param length - 문자열 길이
	 * @return 검사 결과 유무
	 */
	public static boolean isDate(String date, int length) {
		if (date == null || date.length() != length) {
			return false;
		}
		
		char[] ch = date.toCharArray();
		for (int i=0; i<length; i++) {
			if (!Character.isDigit(ch[i])) {
				return false;
			}
		}
		
		return true;
	}
	
	/**
	 * 문자열을 Date 형식으로 포멧
	 * yyyy-mm-dd (-) 는 delim
	 * @param date
	 * @param delim
	 * @return
	 */
	public static String DateFormat(String date, String delim) {
		
		if(date==null || date.equals("")) {
			return "";
		} else {
			delim = delim==null ? "" : delim;
			
			String yyyy = date.substring(0, 4);
			String mm = date.substring(5, 7);
			String dd = date.substring(8, 10);
			
			String result = yyyy + delim + mm + delim + dd;
			
			return result;
		}
	}
	
	/**
	 * 문자열을 Date 형식으로 포멧
	 * yyyy-mm-dd (-) 는 delim
	 * @param date
	 * @param delim
	 * @return
	 */
	public static String DateFormat(Timestamp date, String delim) {
		
		if(date==null) {
			return "";
		} else {
			delim = delim==null ? "" : delim;
			
			String yyyy = (date.toString()).substring(0, 4);
			String mm = (date.toString()).substring(5, 7);
			String dd = (date.toString()).substring(8, 10);
			
			String result = yyyy + delim + mm + delim + dd;
			
			return result;
		}
	}
	
	/**
	 * 문자열을 시간 형식으로 포멧
	 * yyyy-mm-dd hh24:mm:ss
	 * @param date
	 * @return
	 */
	public static String TimeFormatHH24(String date) {
		
		if(date==null || date.equals("")) {
			return "";
		} else {
			String hh = date.substring(11, 13);
			
			String result = hh;
			
			return result;
		}
	}
	
	/**
	 * 문자열을 시간 형식으로 포멧
	 * yyyy-mm-dd hh24:mm:ss
	 * @param date
	 * @return
	 */
	public static String TimeFormatHH24(Timestamp date) {
		
		if(date==null) {
			return "";
		} else {
			String hh = (date.toString()).substring(11, 13);
			
			String result = hh;
			
			return result;
		}
	}
	
	/**
	 * TimestampToString 형식을 String 으로 변환
	 * @param time
	 * @return
	 */
	public static String TimestampToString(Timestamp time) {
		String t1 = time.toString();
		String rsTime = t1.substring(0, 18);
		return rsTime;
	}
	
	/**
	 * TimestampToString 형식을 String 으로 변환
	 * @param time
	 * @return
	 */
	public static String TimestampToString(String time) {
		String t1 = time;
		String rsTime = t1.substring(0, 18);
		return rsTime;
	}
	
	/**
	 * 한글값을 url 주소로 넘겨줄 수 있게 인코딩 함
	 * @param uri
	 * @return
	 */
	public static String URLEncoder(String str) {
		String encodeStr = ""; 
		try {
			if(str==null) {
				str = "";
			}
			encodeStr = URLEncoder.encode(str, "UTF-8");
		} catch(UnsupportedEncodingException ex) {
			ex.printStackTrace(System.out);
		}
		return encodeStr;
	}
	
	/**
	 * 한글값을 url 주소로 받을 수 있게 디코딩 함
	 * @param uri
	 * @return
	 */
	public static String URLDecoder(String str) {
		String decodeStr = ""; 
		try {
			if(str==null) {
				str = "";
			}
			decodeStr = URLDecoder.decode(str, "UTF-8");
		} catch(UnsupportedEncodingException ex) {
			ex.printStackTrace(System.out);
		}
		return decodeStr;
	}
	
	/**
	 * 태그를 태그표현식으로 바꿈
	 * @param str
	 * @return
	 */
	public static String HTMLDecoder(String str) {
		if(str==null) str="";
		str = str.replaceAll("\"", "&quot;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("\r\n", "<br/>");
		return str;
	}
	
	/**
	 * 태그표현식을 태그로 바꿈
	 * @param str
	 * @return
	 */
	public static String HTMLEncoder(String str) {
		if(str==null) str="";
		str = str.replaceAll("&quot;", "\"");
		str = str.replaceAll("&gt;", ">");
		str = str.replaceAll("&lt;", "<");
		str = str.replaceAll("&amp;", "&");
		//str = str.replaceAll("<br/>", "\r\n");
		return str;
	}
	
	/**
	 * 엔터를 br 태그로 바꿈
	 * @param str
	 * @return
	 */
	public static String CarriageReturnDecoder(String str) {
		if(str==null) str="";
		str = str.replaceAll("\r\n", "<br/>");
		return str;
	}

	/**
	 * br 태그를 엔터로 바꿈
	 * @param str
	 * @return
	 */
	public static String CarriageReturnEncoder(String str) {
		if(str==null) str="";
		str = str.replaceAll("<br/>", "\r\n");
		return str;
	}
	
	/**
	 * 엔터를 없앰
	 * @param str
	 * @return
	 */
	public static String CarriageReturnDelete(String str) {
		if(str==null) str="";
		str = str.replaceAll("\r\n", "");
		str = str.replaceAll("'", "&quot;");
		return str;
	}
	
	/**
	 * 8자리 날자로 리턴
	 * @param time
	 * @return
	 */
	public static String getDateToString(Timestamp time) {
		
		String yyyy = (time.toString()).substring(0, 4);
		String mm = (time.toString()).substring(5, 7);
		String dd = (time.toString()).substring(8, 10);
		
		String result = yyyy + mm + dd;
		
		return result;
	}
	
	/**
	 * 6자리 시간으로 리턴
	 * @param time
	 * @return
	 */
	public static String getTimeToString(Timestamp time) {
		
		String hh = (time.toString()).substring(11, 13);
		String mm = (time.toString()).substring(14, 16);
		String ss = (time.toString()).substring(17, 19);
		
		String result = hh + mm + ss;
		
		return result;
	}
	
	/**
	 * 8자리 날자를 날자로 리턴
	 * @param time
	 * @return
	 */
	public static String getStringToDate(String str) {
		
		String yyyy = str.substring(0, 4);
		String mm = str.substring(4, 6);
		String dd = str.substring(6, 8);
		
		String result = yyyy + "-" + mm + "-" + dd;
		
		return result;
	}
	
	/**
	* 왼쪽에 문자를 특정 길이가 되게 채운다.
	* @param nValue 변경할 값
	* @param nSize 변경될 값의 전체길이
	* @param fillchar 채울 문자
	* @return String tmpString 결과값
	* nValue = "22"; nSize = 4; fillchar = '*'; tmpString = "**22"; 이 된다. 
	* nValue의 길이가 nSize보다 작으면 nValue를 반환한다.
	*/
	public static String strFillLeft(String nValue , int nSize , char fillchar){
		String tmpString = nValue;
		int len = nValue.length();
		if( len >= nSize ) return nValue;
		tmpString = strFillString(String.valueOf(fillchar),nSize-len) + nValue;		
		return tmpString;	
	}
	/**
	* 오른쪽에 문자를 특정 길이가 되게 채운다.
	* @param nValue 변경할 값
	* @param nSize 변경될 값의 전체길이
	* @param fillchar 채울 문자
	* @return String tmpString 결과값
	* nValue = "22"; nSize = 4; fillchar = '*'; tmpString = "**22"; 이 된다. 
	* nValue의 길이가 nSize보다 작으면 nValue를 반환한다.
	*/
	public static String strFillRight(String nValue , int nSize , char fillchar){
		String tmpString = nValue;
		int len = nValue.length();
		if( len >= nSize ) return nValue;
		tmpString = nValue + strFillString(String.valueOf(fillchar),nSize-len);		
		return tmpString;	
	}	
	/**
	* 문자열을  nCount 만큼 반복해서 연결해 준다.
	* @param srValue 변경할 값
	* @param nCount 반복할 횟수
	* @return tmpString 결과값
	*/
	public static String strFillString(String srValue,int nCount){
		StringBuffer temp = new StringBuffer();
		for(int i=0;i<nCount;i++){
			temp.append(srValue);
		}
		return temp.toString();
	}	

	



	
	
	
    /**
     * 주민번호 사이에 - 처리하기 위한 메소드
     * @param str - 주민번호 13자리
     * @return 14자리 주민번호
     */
    public static String getJuminNo( String str )
    {
        String juminNo = "";
        if( str != null && str.length() == 13 )
        {
            juminNo = str.substring( 0, 6 ) + "-" + str.substring( 6, 13 );
        }
        else
        {
            juminNo = str;
        }
        return juminNo;
    }
    
    /**
     * 주민번호 사이에 -******* 처리하기 위한 메소드
     * @param str - 주민번호 13자리
     * @return 14자리 주민번호
     */
    public static String getJuminNoHidden( String str )
    {
        String juminNo = "";
        if( str != null && str.length() == 13 )
        {
            juminNo = str.substring( 0, 6 ) + "-*******";
        }
        else
        {
            juminNo = str;
        }
        return juminNo;
    }

    /**
     * 카드번호 사이에 - 처리하기 위한 메소드
     * @param str - 카드번호16자리
     * @return 카드번호 19자리
     */
    public static String getCardNo( String str )
    {
        String cardNo = "";
        if( str != null && str.length() == 16 )
        {
            cardNo = str.substring( 0, 4 ) + "-" + str.substring( 4, 8 ) +
                "-" + str.substring( 8, 12 ) + "-" + str.substring( 12, 16 );
        }
        else
        {
            cardNo = str;
        }
        return cardNo;
    }

    /**
     * 카드번호 사이에 - 처리하고 * 마스킹 위한 메소드
     * @param str - 카드번호16자리
     * @return 카드번호 19자리
     */
    public static String getCardNoHidden( String str )
    {
        String cardNo = "";
        if( str != null && str.length() == 16 )
        {
            cardNo = str.substring( 0, 4 ) + "-" + str.substring( 4, 8 ) +
                "-****-" + str.substring( 12, 16 );
        }
        else
        {
            cardNo = str;
        }
        return cardNo;
    }

    /**
     * 날짜 사이에 구분자 처리하기 위한 메소드
     * @param str - 날짜 6자리 또는 8자
     * @param s - 구분자
     * @return 날짜 10자리
     */
    public static String getDateFormat( String str, String s )
    {
        String ymd = "";
        if( str != null && str.length() == 6 )
        {
        	ymd = str.substring( 0, 4 ) + s + str.substring( 4, 6 );
        	
        } else if( str != null && str.length() == 8 )
        {
        	ymd = str.substring( 0, 4 ) + s + str.substring( 4, 6 ) +
        	      s + str.substring( 6, 8 );
        }
        else
        {
        	ymd = str;
        }
        return ymd;
    }
    /**
     * 금액, 포인트등의 값에 ,(콤마)를 넣는 메소드
     * @param str - 대상문자열
     * @return 콤마붙인 문자열
     */
    public static String setComma(String str){
    	if("".equals(str)||str==null){
    		return "0";
    	}else{
    		DecimalFormat formater = new java.text.DecimalFormat("###,###,###,###,###,###,###,###.#");
    		str = formater.format(Float.parseFloat(str));
    		return str;
    	}
    }
    /**
     * 금액, 포인트등의 값에 ,(콤마)를 넣는 메소드
     * @param val - 대상 int
     * @return 콤마붙인 문자열
     */
    public static String setComma(int val){
    	//if(val<1) val = 0;
    	return setComma(""+val);
    }
    
    /**
	 * 문자열을 시간 형식으로 포멧
	 * yyyy-mm-dd hh24:mm:ss
	 * @param date
	 * @return
	 */
	public static String getStringToTime(String date) {
		
		if(date==null || date.equals("")) {
			return "";
		} else {
			String hh = date.substring(0, 2);
			String mi = date.substring(2, 4);
			String ss = date.substring(4, 6);
			
			String result = hh + "." + mi + "." + ss;
			
			return result;
		}
	}
}
