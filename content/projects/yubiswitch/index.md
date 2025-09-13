---
title: "Yubiswitch"
---

{{< image path=yubiswitch/nano.jpg width=300 >}}

`yubiswitch` is an OSX status bar application to enable/disable a [Yubikey Nano or Neo](https://www.yubico.com/products/yubikey-hardware/) from Yubico.

Yubico is the producer of the Yubikeys: a hardware authentication device, designed to provide an easy to use and secure compliment to the traditional username and password.

By touching the exposed gold edge, a YubiKey Nano emits a One Time Password (OTP) as if it was typed in from a keyboard. The unique passcode is verified by a YubiKey compliant application.

So far all looks great doesn't it? :joy:

```text
flnurfrdjvfrlutthjtjvcbcrlbbnnuu
ejehlrlrclcllukjgehhrttbknnbjdfn
njlvvnherbjvnljdvvvnihrfikufjucr
jhgkhrubrnuchhhbhrugvbenrhkcvich
```

Whooops! You see? I brought my laptop (lid opened) with me for a walk to a meeting room holding it with my right hand touching the golden stripe and this caused the Nano to start sending random OTP passwords to my Vim session, and to the FB chat window I had opened with my wife, and right now she's been asking WTF I've been writing :stuck_out_tongue:

This status bar app allows you to avoid sending those accidental OTP passwords by allowing you to enable or disable the yubikey using a convenient global keyboard hot key that you can configure yourself.
This was my first (and probably last) macOS application!
I used it as an excuse to learn some ObjectiveC.

- [GitHub Repository](https://github.com/pallotron/yubiswitch)
