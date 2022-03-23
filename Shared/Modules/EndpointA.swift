//
//  EndpointA.swift
//  PassiveWallet
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Balance
struct CovalentObject: Codable {
    let data: AddressAssets
    let error: Bool
    let errorMessage, errorCode: JSONNull?

    enum CodingKeys: String, CodingKey {
        case data, error
        case errorMessage = "error_message"
        case errorCode = "error_code"
    }
}

// MARK: - AddressAssets
struct AddressAssets: Codable {
    let address, updatedAt, nextUpdateAt, quoteCurrency: String
    let chainID: Int
    let items: [Token]
    let pagination: JSONNull?

    enum CodingKeys: String, CodingKey {
        case address //ethBalance,name
        case updatedAt = "updated_at"
        case nextUpdateAt = "next_update_at"
        case quoteCurrency = "quote_currency"
        case chainID = "chain_id"
        case items, pagination
    }
}

// MARK: - Item
struct Token: Codable {
    let contractDecimals: Int
    let contractName, contractTickerSymbol, contractAddress: String?
    let supportsErc: [SupportsErc]?
    let logoURL: String?
    let lastTransferredAt: String?
    let type: String? // Leave type as string
    let balance, balance24H: String?
    var balanceEthFormat: String? /// Add usd when fetch request
    let quoteRate, quoteRate24H: Double?
    let quote: Double?
    let quote24H: Double?
    let nftData: [NftDatum]?

    enum CodingKeys: String, CodingKey {
        case contractDecimals = "contract_decimals"
        case contractName = "contract_name"
        case contractTickerSymbol = "contract_ticker_symbol"
        case contractAddress = "contract_address"
        case supportsErc = "supports_erc"
        case logoURL = "logo_url"
        case lastTransferredAt = "last_transferred_at"
        case type, balance
        case balanceEthFormat
        case balance24H = "balance_24h"
        case quoteRate = "quote_rate"
        case quoteRate24H = "quote_rate_24h"
        case quote
        case quote24H = "quote_24h"
        case nftData = "nft_data"
    }
}

// MARK: - NftDatum
struct NftDatum: Codable {
    let tokenID, tokenBalance: String?
    let tokenURL: String?
    let supportsErc: [SupportsErc]?
    let tokenPriceWei, tokenQuoteRateEth: JSONNull?
    let originalOwner: String?
    let externalData: ExternalData?
    let owner: String?
    let ownerAddress, burned: JSONNull?

    enum CodingKeys: String, CodingKey {
        case tokenID = "token_id"
        case tokenBalance = "token_balance"
        case tokenURL = "token_url"
        case supportsErc = "supports_erc"
        case tokenPriceWei = "token_price_wei"
        case tokenQuoteRateEth = "token_quote_rate_eth"
        case originalOwner = "original_owner"
        case externalData = "external_data"
        case owner
        case ownerAddress = "owner_address"
        case burned
    }
}

// MARK: - ExternalData
struct ExternalData: Codable {
    let name, externalDataDescription: String?
    let image, image256, image512, image1024: String?
    let animationURL: String?
    let externalURL: String?
    let attributes: [Attribute]?
    let owner: JSONNull?

    enum CodingKeys: String, CodingKey {
        case name
        case externalDataDescription = "description"
        case image
        case image256 = "image_256"
        case image512 = "image_512"
        case image1024 = "image_1024"
        case animationURL = "animation_url"
        case externalURL = "external_url"
        case attributes, owner
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let traitType, value: String?

    enum CodingKeys: String, CodingKey {
        case traitType = "trait_type"
        case value
    }
}

enum SupportsErc: String, Codable {
    case erc1155 = "erc1155"
    case erc20 = "erc20"
    case erc721 = "erc721"
}

enum TypeEnum: String, Codable {
    case cryptocurrency = "cryptocurrency"
    case dust = "dust"
    case nft = "nft"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
