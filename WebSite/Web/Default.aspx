<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HR_Grove_Web._Default" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>HR Grove System | Login</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/AdminLTE/plugins/fontawesome-free/css/all.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="/AdminLTE/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/AdminLTE/dist/css/adminlte.min.css">
    <!-- Toastr -->
    <link rel="stylesheet" href="/AdminLTE/plugins/toastr/toastr.min.css">
</head>
<body class="hold-transition login-page">
    <div class="login-box">
        <!-- /.login-logo -->
        <div class="card card-outline card-primary">
            <div class="card-header text-center">
                <a href="#" class="h1"><b>HR</b></a>
            </div>
            <div class="card-body">
                <p class="login-box-msg">Sign in to start your session</p>

                <form runat="server" method="post">
                    <div class="input-group mb-3">
                        <%--<input type="email" class="form-control" placeholder="Email">--%>
                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="UserName"></asp:TextBox>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-envelope"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <%--<input type="password" class="form-control" placeholder="Password">--%>
                        <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-8">
                            <div class="icheck-primary">
                                <input type="checkbox" id="remember">
                                <label for="remember">
                                    Remember Me
             
                                </label>
                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-4">
                            <asp:Button runat="server" ID="btnLogin" class="btn btn-primary btn-block" Text="Login" OnClick="btnLogin_Click" />
                        </div>
                        <!-- /.col -->
                    </div>
                </form>

                <div class="social-auth-links text-center mt-2 mb-3" style="display: none;">
                    <a href="#" class="btn btn-block btn-primary">
                        <i class="fab fa-facebook mr-2"></i>Sign in using Facebook
                    </a>
                    <a href="#" class="btn btn-block btn-danger">
                        <i class="fab fa-google-plus mr-2"></i>Sign in using Google+
                    </a>
                </div>
                <!-- /.social-auth-links -->
                <p class="mb-1">
                    <a href="#">I forgot my password</a>
                </p>
                <p class="mb-1">
                    <asp:Label runat="server" ID="lberror" Style="color: red;"></asp:Label>
                </p>
                <p class="mb-0" style="display: none;">
                    <a href="#" class="text-center">Register a new membership</a>
                </p>
            </div>
            <table style="text-align: center;">
                <tr>
                    <td>
                        <a href="https://diag.e-technology.vn/Services/Android/android.html">
                            <img src="Images/icon_android.png" style="width: 100px" /></a>
                    </td>
                    <td>
                        <%--<img src="Images/icon_ios.png" style="width:100px" />--%>
                        <a href="https://testflight.apple.com/join/l9BOu2F7">
                            <img src="Images/icon_ios.png" style="width: 100px" /></a>
                    </td>
                </tr>
            </table>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->
    </div>
    <!-- /.login-box -->

    <!-- jQuery -->
    <script src="/AdminLTE/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="/AdminLTE/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="/AdminLTE/dist/js/adminlte.min.js"></script>


</body>
</html>
