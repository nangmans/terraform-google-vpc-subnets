# terraform-google-subnet

이 모듈은 [terraform-google-module-template](https://stash.wemakeprice.com/users/lswoo/repos/terraoform-google-module-template/browse)에 의해서 생성되었습니다. 

The resources that this module will create are:

- Create subnets with the provided name

## Usage

모듈의 기본적인 사용법은 다음과 같습니다:

```hcl
module "subnet" {
  source = "git::https://stash.wemakeprice.com/scm/tgm/terraform-google-vpc-subnets.git"

  project_id         = "my-prod-project"
  network            = "my-prod-network"
  config_directories = [
    "./prod",
    "./common"
  ]
}
```

모듈 사용의 예시는 [examples](./examples/) 디렉토리에 있습니다.

## Rule definition format and structure
Firewall rule configuration은 폴더 내에 yaml 파일의 형태로 위치해야 합니다. Firewall 규칙 구조는 다음과 같습니다.
```
subnet-name: # Subnet 이름. Module에 의해 naming 컨벤션이 조정됩니다.

  # required attributes
  region: asia-northeast3 # Subnet의 리전
  ip_cidr_range: 10.0.0.0/24 # Subnet의 Internal IPv4 CIDR range

  # optional attributes
  enable_private_google_access: false # Private Google Access 활성화
  purpose : PRIVATE # Subnet의 목적.INTERNAL_HTTPS_LOAD_BALANCER , PRIVATE 혹은 PRIVATE_SERVICE_CONNECT 
  role : BACKUP # Subnet의 역할. purpose = INTERNAL_HTTPS_LOAD_BALANCER일 경우에만 사용 가능. ACTIVE 혹은 BACKUP
  stack_type : IPV4_ONLY # Subnet의 IPv6 활성화 여부. IPV4_ONLY 혹은 IPV4_IPV6
  ipv6_access_type : EXTERNAL # Subnet IPv6 주소의 액세스 타입. INTERNAL 혹은 EXTERNAL
  enable_private_google_access_ipv6 : false # IPv6에 대한 Private Google Access 활성화
  
  secondary_ip_ranges:              # map of secondary ip ranges
    secondary-range-a: 192.168.0.0/24

  flow_logs_config:                        # # Subnet flowlog 옵션. purpose=INTERNAL_HTTPS_LOAD_BALANCER일 경우 사용 불가. Empty map으로 둘 경우 default값 사용.
    aggregation_interval: INTERVAL_5_SEC # flow log 집계 간격. INTERVAL_5_SEC, INTERVAL_30_SEC, INTERVAL_1_MIN, INTERVAL_5_MIN, INTERVAL_10_MIN 혹은 INTERNAL_15_MIN 사용 가능. Default는 INTERVAL_5_SEC
    flow_sampling: 0.6 # flow log 샘플링 레이트. 0 ~ 1 사이 값 사용 가능. Default는 0.5
    metadata: EXCLUDE_ALL_METADATA # flow log에 포함될 metadata. INCLUDE_ALL_METADATA , EXCLUDE_ALL_METADATA , CUSTOM_METADATA 사용 가능
    metadata_fields: [
    ] # flow log에 포함할 custom metadata field. metadata = CUSTOM_METADATA 일 경우 사용 가능.
    filter_expression: "inIpRange(connection.src_ip, '10.0.0.0/8')" # flow log에 사용할 필터. CEL 표현식 사용
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_directories | yaml 포맷의 firewall config 파일이 위치한 폴더 경로의 List. 파일의 접미사는 반드시 `.yaml`여야 함. | `list(string)` | n/a | yes |
| network | Subnet을 생성할 네트워크명 | `any` | n/a | yes |
| project\_id | 프로젝트 ID | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network\_subnet | 생성한 Subnet |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

이 모듈을 사용하기 위해 필요한 사항을 표기합니다.

### Software

아래 dependencies들이 필요합니다:

- [Terraform][terraform] v1.3
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v4.40.0

### Service Account

이 모듈의 리소스를 배포하기 위해서는 아래 역할이 필요합니다:

- Storage Admin: `roles/compute.networkAdmin`

[Project Factory module][project-factory-module] 과
[IAM module][iam-module]로 필요한 역할이 부여된 서비스 어카운트를 배포할 수 있습니다.

### APIs

이 모듈의 리소스가 배포되는 프로젝트는 아래 API가 활성화되어야 합니다:

- None

[Project Factory module][project-factory-module]을 이용해 필요한 API를 활성화할 수 있습니다..

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).

## TO DO

- [ ] Example README 번역
