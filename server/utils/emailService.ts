import nodemailer from "nodemailer";

const transporter = nodemailer.createTransport({
  host: process.env.EMAIL_HOST,
  port: Number(process.env.EMAIL_PORT) || 587,
  secure: false,
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

export const sendErrorEmail = async (error: Error) => {
  try {
    const mailOptions = {
      from: `"System Admin" <${process.env.EMAIL_FROM}>`,
      to: process.env.EMAIL_USER, // Sending to yourself for now
      subject: `CRITICAL ERROR: ${error.name}`,
      html: `
        <h3>System Alert</h3>
        <p><strong>Error Name:</strong> ${error.name}</p>
        <p><strong>Message:</strong> ${error.message}</p>
        <p><strong>Time:</strong> ${new Date().toISOString()}</p>
        <hr />
        <h4>Stack Trace:</h4>
        <pre style="background: #f4f4f4; padding: 10px; border-radius: 5px;">${error.stack}</pre>
      `,
    };

    const info = await transporter.sendMail(mailOptions);
    console.log("Error Alert Email sent: %s", info.messageId);
  } catch (emailError) {
    console.error("FAILED TO SEND ERROR EMAIL:", emailError);
    console.error("Original Error was:", error);
  }
};
