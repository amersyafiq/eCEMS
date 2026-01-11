/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package com.ecems.filter;

import java.io.IOException;

import com.ecems.model.Student;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
@WebFilter(filterName = "authFilter", urlPatterns = {"/*"})
public class authFilter implements Filter {
    
    public authFilter() {
    }

    /**
     *
     * @param sr
     * @param sr1
     * @param fc
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest sr, ServletResponse sr1,
            FilterChain fc)
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) sr;
        HttpServletResponse response = (HttpServletResponse) sr1;
        
        String contextPath = request.getContextPath();
        String uri = request.getRequestURI();
        String path = uri.substring(contextPath.length());

        HttpSession session = request.getSession(false);
        
        // Public Path (Static Resources, e.g.: CSS, JS, etc )
        if (
                // Index
                (
                    session == null &&
                    (path.equals("/") ||
                    path.equals("/index"))
                ) ||
                
                // Login or Register
                path.equals("/login") ||
                path.equals("/register") ||

                path.equals("/logout") ||

                // Static resources
                path.startsWith("/assets/") ||
                
                // Partials
                path.endsWith(".jspf")
            ) {
            fc.doFilter(request, response);
            return;
        }

        String role = (session == null) ? null : (String) session.getAttribute("role");

        if (role == null) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        if (path.startsWith("/views/student/") && !"student".equalsIgnoreCase(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Student only.");
            return;
        }

        if (path.startsWith("/views/staff/") && !"staff".equalsIgnoreCase(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Staff only.");
            return;
        }

        if (path.equals("/") || path.equals("/index")) {
            String dashboardPath = "";
            
            if ("student".equalsIgnoreCase(role)) {
                dashboardPath = "/views/student/index.jsp";
            } else if ("staff".equalsIgnoreCase(role)) {
                dashboardPath = "/views/staff/index.jsp";
            }

            if (!dashboardPath.isEmpty()) {
                request.getRequestDispatcher(dashboardPath).forward(request, response);
                return;
            }
        }
        
        fc.doFilter(request, response);
    }

    /**
     * Destroy method for this filter
     */
    @Override
    public void destroy() {
    }
 
}
