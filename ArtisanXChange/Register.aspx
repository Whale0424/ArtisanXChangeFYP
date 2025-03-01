<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ArtisanXChange.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Registration</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>User Registration</h2>
            
            <table>
                <tr>
                    <td>Username:</td>
                    <td>
                        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                            ErrorMessage="Username is required" ControlToValidate="txtUsername" 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                            ErrorMessage="Password is required" ControlToValidate="txtPassword" 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Confirm Password:</td>
                    <td>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                            ErrorMessage="Confirm Password is required" ControlToValidate="txtConfirmPassword" 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvPassword" runat="server" 
                            ErrorMessage="Passwords do not match" ControlToValidate="txtConfirmPassword" 
                            ControlToCompare="txtPassword" ForeColor="Red">*</asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                            ErrorMessage="Email is required" ControlToValidate="txtEmail" 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                            ErrorMessage="Invalid Email Format" ControlToValidate="txtEmail" 
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                            ForeColor="Red">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>Contact Number:</td>
                    <td>
                        <asp:TextBox ID="txtContactNo" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>User Type:</td>
                    <td>
                        <asp:DropDownList ID="ddlUserType" runat="server">
                            <asp:ListItem Text="Select User Type" Value=""></asp:ListItem>
                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                            <asp:ListItem Text="Regular User" Value="Regular"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvUserType" runat="server" 
                            ErrorMessage="User Type is required" ControlToValidate="ddlUserType" 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>