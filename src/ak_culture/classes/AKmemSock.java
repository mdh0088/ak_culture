package ak_culture.classes;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.SocketException;
import java.net.UnknownHostException;

public class AKmemSock {

    public Socket socket = null;
    public String host = null;
    public int port = 0;
    public String approve_no  = null;
    public String return_msg  = null;
    public String vensa_fg    = null;
    public String card_inform = null;
    boolean DEBUG = true;

    BufferedReader inB  = null;
    PrintWriter toServer = null;

    public void setHost(String host, int port) {

        if (DEBUG) {
            System.out.println("CmCardApp.setHost() called...");
        }

        if (host != null) {
            this.host = host;
        }

        if (port > 0) {
            this.port = port;
        }

    }



    public String start() {

        if (DEBUG) {
            System.out.println("CmCardApp.start() called...");
        }

        try {
            socket = new Socket(host, port);

            if (socket != null) {
                inB  = new BufferedReader(new InputStreamReader(socket.getInputStream(), "euc-kr"));
                toServer = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()));
                return "OK";
            } else {
                if (DEBUG) {
                    System.out.println("Fail0000:시스템장애(Exception:In/Out Socket Streams...)");
                }
                return "Fail0000:시스템장애(Exception:In/Out Socket Streams...)";
            }

        } catch ( UnknownHostException e ) {
            if (DEBUG) {
                System.out.println("Fail0000:시스템장애(UnknownHostException):"+host);
            }
            return "Fail0000:시스템장애(UnknownHostException):" + host;
        } catch ( IOException e ) {
            if (DEBUG) {
                System.out.println("Fail0000:시스템장애(IOException):" + host+":"+port);
            }
            return "Fail0000:시스템장애(IOException):" + host+":"+port;
        }


    }


    public String AKmem_run(String card_inform){
        
        if (DEBUG) {
            System.out.println("AKmem_run() called...");
        }

        String line = null;
        String TranHeader = null;
        String recv_buff = null;
        
        try {

            //서버에 카드정보를 보냄
            toServer.println(card_inform);
            toServer.flush();

            //승인여부를 받아옴
            while ( (line = inB.readLine()) != null ) {
                if (line.length() == 0) {
                    break;
                }
                TranHeader = line.substring(0, 6);
                recv_buff  = line.substring(42,line.length());  //실제 필요한 data
            }

           return recv_buff;

        } catch (SocketException e) {
            if (DEBUG) {
                System.out.println("CmCardApp.run():시스템장애(SocketException)");
            }
            return "Fail0000:시스템장애(SocketException)";
        } catch (IOException e) {
            if (DEBUG) {
                System.out.println("CmCardApp.run():시스템장애(IOException)");
            }
            return "Fail0000:시스템장애(IOException)";
        } catch (NullPointerException e) {
            if (DEBUG) {
                System.out.println("CmCardApp.run():시스템장애(NullPointerException)");
            }
            return "Fail0000:시스템장애(NullPointerException)";
        } catch (Exception e) {
            if (DEBUG) {
                System.out.println("CmCardApp.run():시스템장애(Exception)");
            }
            return "Fail0000:시스템장애(Exception)";
        }
    }

    public void stop() {
        if (DEBUG) {
            System.out.println("CmCardApp.stop() called...");
        }

        try {
            if (inB != null) {
                inB.close();
                inB = null;
            }
            if (toServer != null) {
                toServer.close();
                toServer = null;
            }
            if (socket != null) {
                socket.close();
                socket = null;
            }
        } catch (Exception e) {
        } //Ignore errors.
    }

} // end of class
