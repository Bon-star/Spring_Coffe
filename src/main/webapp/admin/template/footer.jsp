<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

        </div>
        <footer class="sticky-footer bg-white">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>Copyright &copy; dxuan</span>
                </div>
            </div>
        </footer>
        </div>
    </div>
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/startbootstrap-sb-admin-2/4.1.4/js/sb-admin-2.min.js"></script>

<script>
    $(document).ready(function () {
        var path = window.location.pathname;
        
        $('.nav-item').removeClass('active');

        if (path.includes("/product")) {
            $('#nav-product').addClass('active');
        } 
        else if (path.includes("/category") || path.includes("/home")) {
            $('#nav-category').addClass('active');
        }
    });
</script>