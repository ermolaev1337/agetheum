# Roles

`Owner` - The owner of the platform. The owner is the only one who can grant roles of `Actor` and `Certifier` to other
users. The owner is the only one who can confirm on-boarding requests from `Actors` and `Certifiers`.

`Actor` - Farmer, Producer, Distributor, etc.

`Certifier` - Certifier of the products (e.g. Organic, Fair Trade, etc.)

# User journey on the web application

## On-boarding

Farmer opens our platform. Farmer sees the instruction:

1) Downloads the Web3 Wallet (e.g. MetaMask, later - our own wallet).
2) Create an account in the Web3 Wallet.
3) Connects the Web3 Wallet to our platform by scanning a QR code.

At this moment Farmer has requested on-boarding

# Confirmation of on-boarding requests from `Actors` and `Certifiers` (from the `Owner` perspective)

On-boarding requests is pending until the `Owner` confirms it.

`Owner` sees the on-boarding requests on the Admin Panel.
`Owner` grants roles of `Actor` and `Certifier` by confirming the
on-boarding requests.
`Actors`, and `Certifiers` receive a notification (as an email, SMS, etc.) that on-boarding request is confirmed.
`Actors` start having access to Actor Dashboard. `Certifiers` start having access to Certifier Dashboard,

# Certification Token Lifecycle

## Creation

1) `Actor` (farmer) requests a token.
2) `Certifiers` see the list of all the requests from different `Actors`.
3) `Certifier` takes a request and starts working on it.
4) `Certifier` visits the `Actor` (his farm) and checks the claimed attributes for certification.
5) If everything as `Actor` claimed, `Certifier` confirms the request.
6) `Actor` receives the token.

## Bundling

7) When `Actor` sells his product to `Producer` (also, an `Actor`) and transfer the corresponding certification token to
   him.
8) `Producer` collects all the certification tokens from different `Actors` and requests bundling them into one token
   for the
   final product.
9) `Certifier` sees the request for bundling and takes it to work on it.
10) If everything as `Producer` claimed, `Certifier` confirms the request.
11) `Producer` receives the token which includes information about all the initial certification tokens from `Actors`
    who
    have contributed to the final in the `bundle` attribute within the metadata
    product.

## Expiration

- Each certification token must include `expiration` attribute within the metadata which is the date when the
  certification token expires.
- The attributes `expiration` represents when the certified product expires and its corresponding certification token
  becomes invalid.

## Sharding

- Sometimes the certified product is going to be sold to different productions.
- In this case, `Actor` requests sharding the certification token into predefined fractions.
- `Certifier` sees the request for sharding and takes it to work on it.
- If everything as `Actor` claimed, `Certifier` confirms the sharding request.
- `Actor` receives the new tokens which include information about the initial certification token in the `sharding`
  attribute within the metadata.

## Proof Range

- For some certificates `Actor` has to proof the land where product is grown or produced.
- Using zkSNARK, `Actor` generates Proof Range for the location of his production without disclosing his location
- The Proof Range proves that the location of production of the `Actor` is within the range of the coordinates which
  is claimed by the `Actor`.

# Roadmap

## Smart Contract

TODO Additional step for `Certifiers` before confirmation of the request when the `Certifier` has started working on a
certain certification request.

TODO Bundling (of tokens when a new product consists of multiple certified components).

TODO Expiration (of tokens according to expiration of the corresponding certified products).

TODO Sharding (of tokens when predefined fractions of the certified product are going to be sold to different
productions).

TODO Proof Range (of farm's coordinates for confirmation of the farm location).

TODO Rating System (for `Certifiers`?).

## Web3 Platform

TODO Landing Page (info about the platform, instruction for on-boarding).

TODO On-boarding requests from `Actors` and `Certifiers` to the `Owner`.

TODO Admin Panel for the `Owner` to confirm on-boarding requests from `Actors` and `Certifiers`.

TODO Actor Dashboard for `Actors` to fill the attributes and request certification tokens.

TODO Certifier Dashboard for `Certifiers` to see the list of requests from `Actors` and reply to them.

TODO Public Dashboard to see the list of certification tokens, how they have been bundled, to be observed via QR codes
from the final products.

## Integration with other platforms

TODO Existing digital solutions for enterprise SAP, etc.

TODO Messenger bots (Telegram, WhatsApp, etc.) for on-boarding and certification requests.