package controlador;

import com.google.gson.Gson;
import dao.Negocio;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.*;

public class control5 extends HttpServlet {

    Negocio obj = new Negocio();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int op = Integer.parseInt(request.getParameter("opc"));
        if (op == 1) {
            verpasajeros(request, response);
        }
        if (op == 2) {
            nexocodviaje(request, response);
        }
        if (op == 3) {
            eliminarpasajeros(request, response);
        }
        if (op == 4) {
            agregarPasajeros(request, response);
        }
        if (op == 5) {
            filtrar(request, response);
        }
        if (op == 6) {
            pasajeroDetalle(request, response);
        }
    }

    protected void verpasajeros(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codigo = request.getParameter("cod");
        double costo = Double.parseDouble(request.getParameter("costo"));

        request.setAttribute("dato", obj.pasajeros(codigo));
        request.setAttribute("dato2", codigo);
        request.setAttribute("dato3", costo);

        String pag = "/pasajeros.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void nexocodviaje(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nroviaje = request.getParameter("nroviaje");

        request.setAttribute("dato", nroviaje);
        request.setAttribute("dato2", obj.consultaPagoPasajero(nroviaje));
        request.setAttribute("dato3", obj.pasajeros2(nroviaje));

        String pag = "/pasajeros_agregar.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void eliminarpasajeros(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numboleta = request.getParameter("cod");
        obj.eliminarPasajeros(numboleta);
        String nroviaje = request.getParameter("numVia");
        double costo = Double.parseDouble(request.getParameter("costo"));
        request.setAttribute("dato", obj.pasajeros(nroviaje));
        request.setAttribute("dato2", nroviaje);
        request.setAttribute("dato3", costo);

        String pag = "/pasajeros.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void agregarPasajeros(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nroviaje = request.getParameter("nroviaje");
        String nombrePasajero = request.getParameter("nombreCliente");
        String[] asientosArray = request.getParameter("asientosSeleccionados").split(",");
        int numEstudiantes = Integer.parseInt(request.getParameter("estudiantes"));
        int numAdultos = Integer.parseInt(request.getParameter("adultos"));
        int numNiños = Integer.parseInt(request.getParameter("niños"));
        double pagoxviaje = Double.parseDouble(request.getParameter("precioPorViaje"));
        double pagototal = Double.parseDouble(request.getParameter("precioTotal"));

        obj.agregarPasajero(nroviaje, nombrePasajero, pagototal);

        int cantidadTotalPasajeros = numEstudiantes + numAdultos + numNiños;
        for (int i = 0; i < cantidadTotalPasajeros; i++) {
            String tipoPasajero;
            if (numEstudiantes > 0) {
                tipoPasajero = "E";
                numEstudiantes--;
            } else if (numAdultos > 0) {
                tipoPasajero = "A";
                numAdultos--;
            } else if (numNiños > 0) {
                tipoPasajero = "N";
                numNiños--;
            } else {
                tipoPasajero = "";
            }

            obj.agregarPasajero2(nroviaje, asientosArray[i], tipoPasajero, pagoxviaje);
        }

        String pag = "/rutas.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }

    protected void filtrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        String nom = request.getParameter("consulta");
        Gson gs = new Gson();
        out.print(gs.toJson(obj.filtraPasajeros(nom)));
    }

    protected void pasajeroDetalle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("noma");

        request.setAttribute("dato", obj.pasajerosDetalle(nombre));
        request.setAttribute("dato2", nombre);

        String pag = "/busqueda_pasajero.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
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
