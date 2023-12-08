package controlador;

import dao.Negocio;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.*;
import org.mindrot.jbcrypt.BCrypt;

public class control1 extends HttpServlet {

    Negocio obj = new Negocio();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int op = Integer.parseInt(request.getParameter("opc"));
        if (op == 1) {
            login(request, response);
        }
        if (op == 2) {
            registro(request, response);
        }
    }

    protected void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");
        String contraEncriptada = obj.login(usuario);

        boolean loginExitoso = false;
        if (contraEncriptada != null) {
            loginExitoso = BCrypt.checkpw(contrasena, contraEncriptada);
        }

        if (loginExitoso) {
            String tipo = obj.tipo_usuario(usuario);
            if("E".equals(tipo)){
                String pag = "/cabecera.jsp";
                request.getRequestDispatcher(pag).forward(request, response);
            }else{
                String pag = "/cabecera2.jsp";
                request.getRequestDispatcher(pag).forward(request, response);
            }
        } else {
            request.setAttribute("error", "Usuario y/o contraseña incorrectos");
            String pag = "/login.jsp";
            request.getRequestDispatcher(pag).forward(request, response);
        }
    }

    protected void registro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");
        String contrasenaEncriptada = BCrypt.hashpw(contrasena, BCrypt.gensalt());

        boolean registro = obj.registrarUsuario(nombres, apellidos, usuario, contrasenaEncriptada);
        System.out.println(registro);

        if (registro) {
            String mensaje = "Registro exitoso. Ahora puedes iniciar sesión.";
            request.setAttribute("mensajeRegistro", mensaje);
            String pag = "/login.jsp";
            request.getRequestDispatcher(pag).forward(request, response);
        } else {
            String error = "El usuario ya existe o hubo un problema en el registro.";
            request.setAttribute("errorRegistro", error);
            String pag = "/registro.jsp";
            request.getRequestDispatcher(pag).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
