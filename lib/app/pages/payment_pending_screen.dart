import 'package:flutter/material.dart';

class PaymentPendingScreen extends StatelessWidget {
  const PaymentPendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optionally, remove the AppBar if you want a full-screen message.
      appBar: AppBar(
        title: const Text('Payment Pending'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.payment_outlined,
                size: 80,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 16),
              const Text(
                'Payment Pending',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Your payment is pending. Please complete your payment or contact support for further assistance.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Optionally, navigate to a payment page or open a dialog.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Redirecting to payment options...')),
                  );
                },
                child: const Text('Resolve Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
